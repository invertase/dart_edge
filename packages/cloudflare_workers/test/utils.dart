import 'package:cloudflare_workers/cloudflare_workers.dart';
import 'package:js/js.dart';
import 'package:node_interop/child_process.dart';
import 'package:node_interop/fs.dart';
import 'package:node_interop/node.dart' hide Process;
import 'dart:js_util' as js_util;

import 'package:node_interop/path.dart';
import 'package:test/test.dart';

final toolPath = path.join(process.cwd(), '.dart_tool');
final inputFile = path.join(toolPath, 'test_file_input.dart');
final outputFile = path.join(toolPath, 'test_file_output.js');
final entryFile = path.join(toolPath, 'test_file_entry.js');

final _fs = fs;
final _childProcess = childProcess;

Future<Miniflare> runOnMiniflare(String code) async {
  // Wrap the test code to reduce test boilerplate.
  final actual = '''
import 'dart:async';
import 'package:cloudflare_workers/cloudflare_workers.dart';

void main() {
  $code
}
''';

  try {
    js_util.callMethod(_fs, 'unlinkSync', [inputFile]);
    js_util.callMethod(_fs, 'unlinkSync', [outputFile]);
    js_util.callMethod(_fs, 'unlinkSync', [entryFile]);
  } catch (e) {
    // ignore
  }

  js_util.callMethod(_fs, 'writeFileSync', [inputFile, actual]);

  // Compile the test dart input file.
  // TODO: Handle errors from compilation.
  js_util.callMethod(
    _childProcess,
    'execSync',
    [
      'dart compile js --server-mode --no-source-maps -o $outputFile $inputFile'
    ],
  );

  // Write a module entry file to mimic the behavior of the Cloudflare Workers.
  // TODO: Handle Durable Objects, Scheduled Events, etc - probably need to make the edge
  // package have this as exportable logic
  js_util.callMethod(_fs, 'writeFileSync', [
    entryFile,
    '''
import './test_file_output.js';

export default {
  async fetch(request, env, ctx) {
    if (self.__dartCloudflareFetchHandler !== undefined) {
      return self.__dartCloudflareFetchHandler(request, env, ctx);
    }
  },
};
'''
  ]);

  // Start miniflare with the entry file.
  final mf = requireMiniflare.miniflare(Options(
    scriptPath: entryFile,
    modules: true,
    kvNamespaces: ['TEST_KV'],
  ));

  // Dispose of this instance when the test is done.
  addTearDown(() => mf.dispose());

  return mf;
}

MiniflareExport get requireMiniflare => require('miniflare');

@JS()
@anonymous
@staticInterop
class Options {
  external factory Options({
    String? script,
    String? scriptPath,
    List<String>? kvNamespaces,
    bool? modules,
  });
}

@JS()
@anonymous
@staticInterop
class Response {
  external factory Response();
}

extension ResponseExtension on Response {
  bool get ok => js_util.getProperty(this, 'ok');

  Future<Response> clone() =>
      js_util.promiseToFuture(js_util.callMethod(this, 'clone', []));

  Future<String> text() => js_util.promiseToFuture(
        js_util.callMethod(this, 'text', []),
      );

  ReadableStream? get body => js_util.getProperty(this, 'body');
}

@JS()
@anonymous
@staticInterop
class MiniflareExport {
  external factory MiniflareExport();
}

extension MiniflareExportExtension on MiniflareExport {
  Response get response => js_util.getProperty(this, 'Response');

  Miniflare miniflare(Options options) {
    return js_util.callConstructor(
      js_util.getProperty(this, 'Miniflare'),
      [options],
    );
  }
}

@JS()
@anonymous
@staticInterop
class Miniflare {
  external factory Miniflare({
    String? script,
  });
}

extension MiniflareExtension on Miniflare {
  Future<Response> dispatchFetch([String? path]) {
    return js_util.promiseToFuture(js_util.callMethod(
        this, 'dispatchFetch', ['http://localhost:8787${path ?? '/'}']));
  }

  Future<void> dispose() {
    return js_util.promiseToFuture(js_util.callMethod(this, 'dispose', []));
  }
}

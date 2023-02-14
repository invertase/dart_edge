import 'package:edge/src/platforms/cloudflare_workers.dart';
import 'package:edge_runtime/edge_runtime.dart';
import 'package:js/js.dart';
import 'package:node_interop/child_process.dart';
import 'package:node_interop/fs.dart';
import 'package:node_interop/node.dart';
import 'dart:js_util' as js_util;

import 'package:node_interop/path.dart';
import 'package:test/test.dart';

// These break when called multiple times.
final _fs = fs;
final _childProcess = childProcess;

final toolPath = path.join(process.cwd(), '.dart_tool');
final inputFile = path.join(toolPath, 'test_file_input.dart');
final outputFile = path.join(toolPath, 'test_file_output.js');
final entryFile = path.join(toolPath, 'test_file_entry.js');

Future<Miniflare> runOnMiniflare(String code) async {
  final workers = CloudflareWorkers();

  try {
    js_util.callMethod(_fs, 'unlinkSync', [inputFile]);
    js_util.callMethod(_fs, 'unlinkSync', [outputFile]);
    js_util.callMethod(_fs, 'unlinkSync', [entryFile]);
  } catch (e) {
    // ignore
  }

  js_util.callMethod(_fs, 'writeFileSync', [
    inputFile,
    '''
import 'dart:async';
import 'package:cloudflare_workers/cloudflare_workers.dart';

void main() {
  $code
}
'''
  ]);

  // Compile the test dart input file.
  js_util.callMethod(
    _childProcess,
    'execSync',
    [
      'dart compile js --server-mode --no-source-maps -o $outputFile $inputFile'
    ],
  );

  String entryFileJs = workers.generateEntryFile('test_file_output.js');
  entryFileJs += workers.generateDurableObjectExport('TestDurableObject');

  // Write a module entry file to mimic the behavior of the Cloudflare Workers.
  js_util.callMethod(_fs, 'writeFileSync', [entryFile, entryFileJs]);

  // Start miniflare with the entry file.
  final mf = requireMiniflare.miniflare(Options(
    scriptPath: entryFile,
    modules: true,
    kvNamespaces: ['TEST_KV'],
    durableObjects: {'TEST_DO': 'TestDurableObject'},
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
    Map<String, String>? durableObjects,
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

  Future<Object?> waitUntil() {
    return js_util.promiseToFuture(js_util.callMethod(this, 'waitUntil', []));
  }

  Future<Object?> dispatchScheduled([int? delay]) {
    return js_util.promiseToFuture(
      js_util.callMethod(this, 'dispatchScheduled', [delay]),
    );
  }

  Future<void> dispose() {
    return js_util.promiseToFuture(js_util.callMethod(this, 'dispose', []));
  }
}

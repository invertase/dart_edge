import 'dart:io';
import 'package:path/path.dart' as p;

import '../utils/compiler.dart';
import '../utils/dev_server.dart';
import 'base_command.dart';

class NetlifyBuildCommand extends BaseCommand {
  @override
  final name = "netlify";

  @override
  final description = "TODO.";

  NetlifyBuildCommand() {
    argParser.addOption('port',
        help: 'The port to run the dev server on.', defaultsTo: '4000');
    argParser.addFlag(
      'dev',
      help:
          'Runs Dart Edge in a local development environment with hot reload via Netlify CLI.',
    );
  }

  Future<void> runDev() async {
    final edgeTool = Directory(
      p.join(Directory.current.path, '.dart_tool', 'edge'),
    );

    // print(Platform.environment);

    final devServer = DevServer(
      logger: logger,
      startScript: devAddEventListener,
      port: argResults!['port'] as String,
      compiler: Compiler(
        logger: logger,
        entryPoint: p.join(Directory.current.path, 'lib', 'main.dart'),
        outputDirectory: edgeTool.path,
        outputFileName: 'main.dart.js',
        level: CompilerLevel.O1,
      ),
    );

    await devServer.start();
  }

  @override
  void run() async {
    // TODO: figure out how to get durable objects from toml

    final isDev = argResults!['dev'] as bool;

    // final netlifyTool = Directory(
    //   p.join(Directory.current.path, '.netlify', 'edge-functions', 'dart_edge'),
    // );

    if (isDev) {
      await runDev();
    }

    // final compiler = Compiler(
    //   logger: logger,
    //   entryPoint: p.join(Directory.current.path, 'lib', 'main.dart'),
    //   outputDirectory: netlifyTool.path,
    //   outputFileName: 'main.dart.js',
    //   level: isDev ? CompilerLevel.O1 : CompilerLevel.O4,
    // );

    // await compiler.compile();

    // // Update the entry file.
    // await File(p.join(netlifyTool.path, 'index.js'))
    //     .writeAsString(edgeFunctionEntryFileDefaultValue('main.dart.js'));
  }
}

const devAddEventListener = '''addEventListener("fetch", async (event) => {
  if (self.__dartFetchHandler !== undefined) {
    event.respondWith(self.__dartFetchHandler(event.request, {}));
  }
});
''';

final edgeFunctionEntryFileDefaultValue =
    (String fileName) => '''import './${fileName}';

export default (request, context) => {
  if (self.__dartFetchHandler !== undefined) {
    return self.__dartFetchHandler(request, context);
  }
}

export const config = { path: "/*" }
''';

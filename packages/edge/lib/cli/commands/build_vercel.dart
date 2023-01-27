import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:hotreloader/hotreloader.dart';

import '../utils/compiler.dart';
import 'base_command.dart';

class VercelBuildCommand extends BaseCommand {
  @override
  final name = "vercel";

  @override
  final description = "Builds the project.";

  VercelBuildCommand() {
    argParser.addFlag(
      'dev',
      help:
          'Runs Dart Edge in a local development environment with hot reload via Vercel CLI.',
    );
  }

  Future<String> _compile(
    String outputDirectory, {
    required CompilerLevel level,
  }) async {
    final outFileName = 'main.dart.js';

    final compiler = Compiler(
      logger: logger,
      entryPoint: p.join(Directory.current.path, 'lib', 'main.dart'),
      outputDirectory: outputDirectory,
      outputFileName: outFileName,
      level: level,
    );

    await compiler.compile();
    return p.join(outputDirectory, outFileName);
  }

  Future<String> _compileDev(String outputDirectory) async {
    final compiledFile = await _compile(
      outputDirectory,
      level: CompilerLevel.O1,
    );

    // Append the event listener to the file - imports don't work
    // so we need to add it to the end of the file.
    await File(compiledFile).writeAsString(
      devAddEventListener,
      mode: FileMode.append,
    );

    return compiledFile;
  }

  Future<Process> _startDevServer(String entryFile) {
    return Process.start('npx', [
      'edge-runtime',
      '--listen',
      entryFile,
      '--port',
      Platform.environment['PORT']!,
    ]);
  }

  Future<void> runDev() async {
    final edgeTool = Directory(
      p.join(Directory.current.path, '.dart_tool', 'edge'),
    );

    String compiledFile = await _compileDev(edgeTool.path);

    // Start Dev Server
    Process devServer = await _startDevServer(compiledFile);
    HotReloader? reloader;

    try {
      reloader = await HotReloader.create(
        debounceInterval: Duration(milliseconds: 50),
        onAfterReload: (ctx) async {
          logger.write('Changes detected - restarting server...');
          devServer.kill();
          await _compileDev(edgeTool.path);
          devServer = await _startDevServer(compiledFile);
          logger.write('Server restarted');
        },
      );
    } catch (e) {
      logger.write('Error - shutting down');
      await reloader?.stop();
      devServer.kill();
      exit(1);
    }
  }

  Future<void> runBuild() async {
    // Make configurable?
    final outputFileName = 'main.dart.js';

    final vercelDirectory = Directory(
      p.join(Directory.current.path, '.vercel'),
    );

    final edgeFunction = Directory(
      p.join(vercelDirectory.path, 'functions', 'dart.func'),
    );

    await _compile(edgeFunction.path, level: CompilerLevel.O4);

    final configFile = File(p.join(vercelDirectory.path, 'config.json'));

    String configFileValue;
    if (await configFile.exists()) {
      // If a config file already exists, merge in the new route.
      final json = jsonDecode(await configFile.readAsString());

      // If there is no routes key, or it is not an iterable, create a new one.
      if (json['routes'] == null || json['routes'] is! Iterable) {
        json['routes'] = [
          {'src': '/.*', 'dest': 'dart'}
        ];
      } else {
        // Otherwise, check if the route already exists.
        final route = (json['routes'] as Iterable).firstWhere(
          (route) => route['dest'] == 'dart',
          orElse: () => null,
        );

        // If the route does not exist, add it.
        if (route == null) {
          json['routes'] = [
            ...json['routes'],
            {'src': '/.*', 'dest': 'dart'},
          ];
        }
      }
      configFileValue = jsonEncode(json);
    } else {
      // Otherwise create a new config file.
      configFileValue = configFileDefaultValue;
    }

    // Write the config file.
    await configFile.writeAsString(configFileValue);

    // Create a File instance of the Edge Function config file.
    final edgeFunctionConfig = File(
      p.join(edgeFunction.path, '.vc-config.json'),
    );

    // Write the Edge Function config file.
    await edgeFunctionConfig.writeAsString(edgeFunctionConfigFileDefaultValue);

    // Write the Edge Function config file.
    await File(p.join(edgeFunction.path, 'entry.js')).writeAsString(
      edgeFunctionEntryFileDefaultValue(outputFileName),
    );
  }

  @override
  void run() async {
    final isDev = argResults!['dev'] as bool;

    if (isDev) {
      await runDev();
    } else {
      await runBuild();
    }
  }
}

const configFileDefaultValue = '''{
  "version": 3,
  "routes": [{ "src": "/.*", "dest": "dart" }]
}
''';

const edgeFunctionConfigFileDefaultValue = '''{
  "runtime": "edge",
  "entrypoint": "entry.js"
}
''';

const devAddEventListener = '''addEventListener("fetch", async (event) => {
  if (self.__dartFetchHandler !== undefined) {
    event.respondWith(self.__dartFetchHandler(event.request));
  }
});
''';

final edgeFunctionEntryFileDefaultValue =
    (String fileName) => '''import './${fileName}';

export default (request) => {
  if (self.__dartFetchHandler !== undefined) {
    return self.__dartFetchHandler(request);
  }
};
''';

import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;

import '../utils/compiler.dart';
import 'base_command.dart';

class VercelBuildCommand extends BaseCommand {
  @override
  final name = "vercel";

  @override
  final description = "Builds the project.";

  BuildCommand() {
    argParser.addFlag(
      'dev',
      help:
          'Runs Dart Edge in a local development environment with hot reload via Vercel CLI.',
    );
  }

  Future<void> runDev() async {
    // IN DEV:
    // 1. Build to .dart_tool/edge
    // 2. Append to the built file :
    // addEventListener("fetch", async (event) => {
    //   if (self.__dartFetchHandler !== undefined) {
    //     event.respondWith(self.__dartFetchHandler(event.request));
    //   }
    // });
    // Start a process to run the edge-runtime.
    // Start a file watch listener - rebuilt dart & restart the edge-runtime process when anything
    // in lib changes.

    final outputFileName = 'main.dart.js';

    final edgeTool = Directory(
      p.join(Directory.current.path, '.dart_tool', 'edge'),
    );

    // Make reusable
    final compiler = Compiler(
      logger: logger,
      entryPoint: p.join(Directory.current.path, 'lib', 'main.dart'),
      outputDirectory: edgeTool.path,
      outputFileName: outputFileName,
      level: CompilerLevel.dev,
    );

    await compiler.compile();

    await File(p.join(edgeTool.path, outputFileName)).writeAsString(
      devAddEventListener,
      mode: FileMode.append,
    );

    // Start process - make reusable
    final process = await Process.start('npx', [
      'edge-runtime',
      '--listen',
      p.join(Directory.current.path, 'test.js'),
      '--port',
      Platform.environment['PORT']!,
    ]);

    // Kill safe
    // process.kill();

    // Watch for (dart) changes, stop process, call compile, start process
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

    final compiler = Compiler(
      logger: logger,
      entryPoint: p.join(Directory.current.path, 'lib', 'main.dart'),
      outputDirectory: edgeFunction.path,
      outputFileName: outputFileName,
      level: CompilerLevel.prod,
    );

    await compiler.compile();

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

    // Create a File instance of the Edge Function config file.
    final edgeFunctionEntry = File(
      p.join(edgeFunction.path, 'entry.js'),
    );

    // Write the Edge Function config file.
    await edgeFunctionEntry
        .writeAsString(edgeFunctionEntryFileDefaultValue(outputFileName));
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

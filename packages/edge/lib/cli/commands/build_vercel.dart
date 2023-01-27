import 'dart:convert';
import 'dart:io';

import 'package:cli_util/cli_logging.dart';
import 'package:path/path.dart' as p;

import '../utils/compiler.dart';
import 'base_command.dart';

class VercelBuildCommand extends BaseCommand {
  @override
  final name = "vercel";

  @override
  final description = "Builds the project.";

  BuildCommand() {}

  @override
  void run() async {
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
      level: CompilerLevel.dev,
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

    exit(0);
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

final edgeFunctionEntryFileDefaultValue =
    (String fileName) => '''import './${fileName}';

export default (request) => {
  if (self.__dartFetchHandler !== undefined) {
    return self.__dartFetchHandler(request);
  }
};
''';

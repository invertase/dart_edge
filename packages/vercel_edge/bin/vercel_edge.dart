import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as p;

void main(List<String> arguments) async {
  print(arguments);
  final mainDartFile = File(p.join(Directory.current.path, 'lib', 'main.dart'));

  if (!await mainDartFile.exists()) {
    print('No main.dart file found in lib directory.');
    exit(1);
  }

  final outputDirectory =
      Directory(p.join(Directory.current.path, '.vercel', 'output'));

  final outputEdgeFunctionDirectory =
      Directory(p.join(outputDirectory.path, 'functions', 'dart.func'));

  final outputDartFile =
      File(p.join(outputEdgeFunctionDirectory.path, 'main.dart.js'));

  print('Compiling ${mainDartFile.path} to ${outputDartFile.path}...');

  final process = await Process.run('dart', [
    'compile',
    'js',
    '-O1',
    '--no-frequency-based-minification',
    '--server-mode',
    '-o',
    outputDartFile.path,
    mainDartFile.path,
  ]);

  stdout.write(process.stdout);
  stderr.write(process.stderr);

  final configFile = File(p.join(outputDirectory.path, 'config.json'));

  String configFileValue = '';

  if (await configFile.exists()) {
    // If a config file already exists, merge in the new route.
    final json = jsonDecode(await configFile.readAsString());
    json['routes'] = [
      ...json['routes'],
      {'src': '/.*', 'dest': 'dart'},
    ];
    configFileValue = jsonEncode(json);
  } else {
    // Otherwise create a new config file.
    configFileValue = configFileDefaultValue;
  }

  // Write the config file.
  await configFile.writeAsString(configFileValue);

  final edgeFunctionConfigFile = File(
    p.join(outputEdgeFunctionDirectory.path, '.vc-config.json'),
  );

  // Write the config file for this function.
  await edgeFunctionConfigFile
      .writeAsString(edgeFunctionConfigFileDefaultValue);

  final edgeFunctionEntryFile = File(
    p.join(outputEdgeFunctionDirectory.path, 'entry.js'),
  );

  await edgeFunctionEntryFile.writeAsString(edgeFunctionEntryFileDefaultValue);
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

const edgeFunctionEntryFileDefaultValue = '''import './main.dart';

export default (request) => {
  if (self.__dartFetchHandler !== undefined) {
    return self.__dartFetchHandler(request);
  }
};
''';

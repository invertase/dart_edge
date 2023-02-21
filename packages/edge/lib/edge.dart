import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:edge/src/config/edge_config.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:path/path.dart' as p;
import 'package:yaml/yaml.dart';

import 'src/commands/dev_command.dart';
import 'src/commands/build_command.dart';
import 'src/commands/new_command.dart';

void main(List<String> args) {
  EdgeCommandRunner().run(args);
}

class EdgeCommandRunner extends CommandRunner<void> {
  final Logger _logger;

  EdgeCommandRunner({
    Logger? logger,
  })  : _logger = logger ?? Logger(),
        super("edge",
            "A Command-Line Interface for managing Dart Edge projects.") {
    /// Add global flags.
    argParser.addFlag(
      'verbose',
      abbr: 'v',
      help: 'Enables verbose logging.',
    );
    print(config);
    addCommand(NewCommand(logger: _logger));
    addCommand(DevCommand(logger: _logger));
    addCommand(BuildCommand(logger: _logger));
  }

  EdgeConfig? _config;

  EdgeConfig get config {
    if (_config != null) {
      return _config!;
    }

    final configFile = File(p.join(Directory.current.path, 'edge.yaml'));
    if (!configFile.existsSync()) {
      return EdgeConfig.empty();
    }

    try {
      final yamlMap = loadYaml(configFile.readAsStringSync()) as YamlMap;
      _config = EdgeConfig.fromJson(Map<String, dynamic>.from(yamlMap.value).cast<String, dynamic>());
      return _config!;
    } catch (e, s) {
      _logger.err(
          'Failed to parse the edge.yaml file. Please check that the config file is in the correct format.');
      _logger.err(e.toString());
      _logger.err(s.toString());
      exit(1);
    }
  }

  @override
  void printUsage() {
    _logger.info(usage);
  }

  @override
  Future<void> run(Iterable<String> args) async {
    final argResults = argParser.parse(args);

    if (argResults['verbose'] == true) {
      _logger.level = Level.verbose;
    }

    _logger.detail('Running command: edge ${args.join(' ')}');

    return super.run(args);
  }
}

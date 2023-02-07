import 'dart:io';
import 'package:mason/mason.dart';
import 'package:path/path.dart' as p;
import 'package:prompts/prompts.dart' as prompts;

import '../logger.dart';
import 'base_command.dart';

class NewCommand extends BaseCommand {
  @override
  final name = "new";

  @override
  final description = "Create a new Dart Edge project from a template.";

  NewCommand() {
    addSubcommand(VercelNewCommand());
    addSubcommand(CloudflareNewCommand());
  }
}

class VercelNewCommand extends BaseCommand {
  @override
  final name = "vercel_edge";

  @override
  final description = "Create a new Vercel project using Dart Edge.";

  @override
  final takesArguments = true;

  VercelNewCommand() {
    argParser.addCommand('path');
    argParser.addFlag(
      'shelf',
      help:
          'Whether to use the shelf package for routing and handling requests.',
    );
  }

  @override
  void run() async {
    final path =
        argResults!.arguments.isEmpty ? '.' : argResults!.arguments.first;

    return _BrickGenerator(
      brick: 'vercel_edge',
      command: 'vercel dev',
      path: path.isEmpty ? '.' : path,
      variables: {
        'shelf': argResults?['shelf'] ?? false,
      },
    ).generate();
  }
}

class CloudflareNewCommand extends BaseCommand {
  @override
  final name = "cloudflare_workers";

  @override
  final description =
      "Create a new Cloudflare Workers project using Dart Edge.";

  VercelNewCommand() {
    argParser.addFlag(
      'shelf',
      help:
          'Whether to use the shelf package for routing and handling requests.',
    );
  }

  @override
  void run() async {
    final path =
        argResults!.arguments.isEmpty ? '.' : argResults!.arguments.first;

    return _BrickGenerator(
      brick: 'cloudflare_workers',
      command: 'wrangler dev --local',
      path: path.isEmpty ? '.' : path,
      variables: {},
    ).generate();
  }
}

class _BrickGenerator {
  final String brick;
  final String path;
  final Map<String, dynamic> variables;
  final String? command;

  _BrickGenerator({
    required this.brick,
    required this.path,
    required this.variables,
    this.command,
  });

  Future<void> generate() async {
    final outputDir = Directory(p.joinAll([Directory.current.path, path]));

    if (await outputDir.exists()) {
      logger.error(
        'Directory ${outputDir.path} already exists. Please choose a different location.',
      );
      exit(1);
    }

    final confirmed = prompts.getBool(
      'Create a new Dart Edge project in ${outputDir.path}?',
      defaultsTo: true,
    );

    if (!confirmed) {
      exit(0);
    }

    final progress = logger.progress('Cloning template');

    final ref = Brick.git(
      GitPath(
        'https://github.com/invertase/dart_edge',
        path: 'bricks/$brick',
      ),
    );

    final generator = await MasonGenerator.fromBrick(ref);
    final target = DirectoryGeneratorTarget(
        Directory(p.joinAll([Directory.current.path, path])));
    await generator.generate(target, vars: variables);

    progress.finish(showTiming: true);
    logger.success('Successfully cloned template.');
    logger.lineBreak();
    logger.write('To get started, run the following commands:');
    logger.lineBreak();
    if (path.isNotEmpty) logger.hint('cd $path/'.prefix('\$').indent(2));
    logger.hint('dart pub get'.prefix('\$').indent(2));
    if (command != null && command!.isNotEmpty) {
      logger.hint('$command'.prefix('\$').indent(2));
    }
    logger.lineBreak();
  }
}

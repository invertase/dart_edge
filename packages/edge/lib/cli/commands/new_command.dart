import 'dart:io';

import 'package:mason/mason.dart';

import 'base_command.dart';

class NewCommand extends BaseCommand {
  @override
  final name = "new";

  @override
  final description = "Create a new Dart Edge project from a template.";

  NewCommand() {
    addSubcommand(VercelNewCommand());
  }

  @override
  void run() async {}
}

class VercelNewCommand extends BaseCommand {
  @override
  final name = "vercel";

  @override
  final description = "Create a new Vercel project using Dart Edge.";

  VercelNewCommand() {
    argParser.addFlag(
      'shelf',
      help:
          'Whether to use the shelf package for routing and handling requests.',
    );
  }

  @override
  void run() async {
    return _BrickGenerator(brick: 'vercel', variables: {
      'shelf': argResults!['shelf'] as bool,
    }).generate();
  }
}

class _BrickGenerator {
  final String brick;
  final Map<String, dynamic> variables;

  _BrickGenerator({required this.brick, required this.variables});

  Future<void> generate() async {
    final ref = Brick.git(
      GitPath(
        'https://github.com/invertase/dart_edge',
        path: 'bricks/$brick',
      ),
    );

    final generator = await MasonGenerator.fromBrick(ref);
    final target = DirectoryGeneratorTarget(Directory.current);
    await generator.generate(target, vars: variables);
  }
}

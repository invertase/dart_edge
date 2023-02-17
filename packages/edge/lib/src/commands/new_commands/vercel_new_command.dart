import '../../brick_generator.dart';
import '../base_command.dart';

class VercelNewCommand extends BaseCommand {
  @override
  final name = "vercel_edge";

  @override
  final description = "Create a new Vercel project using Dart Edge.";

  @override
  final takesArguments = true;

  VercelNewCommand({
    required super.logger,
  }) {
    argParser.addFlag(
      'shelf',
      help:
          'Whether to use the shelf package for routing and handling requests.',
    );
  }

  @override
  void run() async {
    return BrickGenerator(
      logger: logger,
      brick: 'vercel_edge',
      command: 'vercel dev',
      location: argResults!.rest.isNotEmpty ? argResults!.rest.first : null,
      variables: {
        'shelf': argResults?['shelf'] ?? false,
      },
    ).generate();
  }
}

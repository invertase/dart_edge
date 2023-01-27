import 'base_command.dart';
import 'build_vercel.dart';

class BuildCommand extends BaseCommand {
  @override
  final name = "build";

  @override
  final description = "Builds the project.";

  BuildCommand() {
    addSubcommand(VercelBuildCommand());
  }

  @override
  void run() {
    //
  }
}

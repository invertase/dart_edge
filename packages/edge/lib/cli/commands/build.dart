import 'base_command.dart';
import 'build_vercel.dart';
import 'build_cloudflare.dart';
import 'build_netlify.dart';

class BuildCommand extends BaseCommand {
  @override
  final name = "build";

  @override
  final description = "Builds the project.";

  BuildCommand() {
    addSubcommand(CloudflareBuildCommand());
    addSubcommand(VercelBuildCommand());
    addSubcommand(NetlifyBuildCommand());
  }
}

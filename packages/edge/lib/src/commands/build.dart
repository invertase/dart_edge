import 'base_command.dart';
import 'build_vercel.dart';
import 'build_cloudflare.dart';
// import 'build_netlify.dart';

class BuildCommand extends BaseCommand {
  @override
  final name = "build";

  @override
  final description =
      "Builds a Dart Edge project for a specific platform provider.";

  BuildCommand() {
    addSubcommand(CloudflareBuildCommand());
    addSubcommand(VercelBuildCommand());
    // addSubcommand(NetlifyBuildCommand());
  }
}

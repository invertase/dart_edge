import 'base_command.dart';
import 'build_commands/build_vercel.dart';
import 'build_commands/build_cloudflare.dart';
import 'build_supabase.dart';
// import 'build_netlify.dart';

class BuildCommand extends BaseCommand {
  @override
  final name = "build";

  @override
  final description =
      "Builds a Dart Edge project for a specific platform provider.";

  BuildCommand({
    required super.logger,
  }) {
    addSubcommand(CloudflareBuildCommand(logger: logger));
    addSubcommand(VercelBuildCommand(logger: logger));
    addSubcommand(SupabaseBuildCommand(logger: logger));
    // addSubcommand(NetlifyBuildCommand());
  }
}

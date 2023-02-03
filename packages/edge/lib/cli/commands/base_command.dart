import 'package:args/command_runner.dart';
import 'package:cli_util/cli_logging.dart';

import '../logger.dart';

abstract class BaseCommand extends Command {
  BaseCommand() {
    final verbose = argResults?['verbose'] ?? false;
    initLogger(verbose ? Logger.verbose() : Logger.standard());
  }
}

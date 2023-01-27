import 'package:args/command_runner.dart';
import 'package:cli_util/cli_logging.dart';

abstract class BaseCommand extends Command {
  late final Logger logger;

  BaseCommand() {
    final verbose = argResults?['verbose'] ?? false;
    logger = verbose ? Logger.verbose() : Logger.standard();
  }

  @override
  // TODO: implement description
  String get description => throw UnimplementedError();

  @override
  // TODO: implement name
  String get name => throw UnimplementedError();
}

import 'package:args/command_runner.dart';
import 'package:mason_logger/mason_logger.dart';

abstract class BaseCommand extends Command {
  final Logger logger;

  BaseCommand({
    required this.logger,
  });
}

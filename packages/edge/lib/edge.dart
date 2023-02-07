import 'package:args/command_runner.dart';

import 'src/commands/dev_command.dart';
import 'src/commands/build.dart';
import 'src/commands/new_command.dart';

void main(List<String> args) {
  EdgeCommandRunner()
    ..addCommand(DevCommand())
    ..addCommand(NewCommand())
    ..addCommand(BuildCommand())
    ..run(args);
}

class EdgeCommandRunner extends CommandRunner<void> {
  EdgeCommandRunner() : super("edge", "A CLI to manage Dart Edge projects.") {
    argParser.addFlag('verbose', abbr: 'v');
  }
}

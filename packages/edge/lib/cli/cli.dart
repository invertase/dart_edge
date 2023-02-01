import 'package:args/command_runner.dart';

import 'commands/build.dart';
import 'commands/new_command.dart';

void main(List<String> args) {
  EdgeCommandRunner()
    ..addCommand(NewCommand())
    ..addCommand(BuildCommand())
    ..run(args);
}

class EdgeCommandRunner extends CommandRunner<void> {
  EdgeCommandRunner()
      : super("edge", "A dart implementation of distributed version control.") {
    argParser.addFlag('verbose', abbr: 'v');
  }
}

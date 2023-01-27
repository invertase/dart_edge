import 'package:args/command_runner.dart';

import 'commands/build.dart';

void main(List<String> args) {
  EdgeCommandRunner()
    ..addCommand(BuildCommand())
    ..run(args);
}

class EdgeCommandRunner extends CommandRunner<void> {
  EdgeCommandRunner()
      : super("edge", "A dart implementation of distributed version control.") {
    argParser.addFlag('verbose', abbr: 'v');
  }
}


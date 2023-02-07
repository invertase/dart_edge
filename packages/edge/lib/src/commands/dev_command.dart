import 'dart:io';

import 'package:path/path.dart' as p;

import '../compiler.dart';
import '../dev_server.dart';
import 'base_command.dart';

class DevCommand extends BaseCommand {
  @override
  final name = "dev";

  @override
  final description = "Runs a local development environment with hot reload.";

  DevCommand() {
    argParser.addOption('port', abbr: 'p', defaultsTo: '3000');
  }

  @override
  void run() async {
    final edgeTool = Directory(
      p.join(Directory.current.path, '.dart_tool', 'edge'),
    );

    final devServer = DevServer(
      port: argResults!['port'],
      compiler: Compiler(
        entryPoint: p.join(Directory.current.path, 'lib', 'main.dart'),
        outputDirectory: edgeTool.path,
        outputFileName: 'main.dart.js',
        level: CompilerLevel.O1,
      ),
    );

    await devServer.start();
  }
}

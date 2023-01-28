import 'dart:io';
import 'package:cli_util/cli_logging.dart';
import 'package:edge/cli/utils/compiler.dart';
import 'package:hotreloader/hotreloader.dart';

class DevServer {
  final Compiler compiler;
  final Logger logger;
  final String startScript;
  final String? port;

  DevServer({
    required this.compiler,
    required this.logger,
    required this.startScript,
    this.port,
  });

  Future<Process> _startEdgeRuntime(String entryFile) {
    return Process.start('npx', [
      'edge-runtime',
      '--listen',
      entryFile,
      '--port',
      port ?? Platform.environment['PORT'] ?? '3000',
    ]);
  }

  Future<String> _compile() async {
    final compiledFile = await compiler.compile();

    await File(compiledFile).writeAsString(
      startScript,
      mode: FileMode.append,
    );

    return compiledFile;
  }

  Future<void> start() async {
    Process devServer = await _startEdgeRuntime(
      await _compile(),
    );

    HotReloader? reloader;

    try {
      reloader = await HotReloader.create(
        debounceInterval: Duration(milliseconds: 50),
        onAfterReload: (ctx) async {
          logger.write('Changes detected - restarting server...');
          devServer.kill();
          devServer = await _startEdgeRuntime(
            await _compile(),
          );
          logger.write('Server restarted');
        },
      );
    } catch (e) {
      logger.write('Error - shutting down');
      logger.write(e.toString());
      await reloader?.stop();
      devServer.kill();
      exit(1);
    }
  }
}

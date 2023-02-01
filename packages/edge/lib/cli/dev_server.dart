import 'dart:async';
import 'dart:io';
import 'package:cli_util/cli_logging.dart';
import 'package:watcher/watcher.dart';
import 'package:path/path.dart' as p;

import 'compiler.dart';

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
    return Process.start(
        'npx',
        [
          'edge-runtime',
          '--listen',
          entryFile,
          '--port',
          port ?? Platform.environment['PORT'] ?? '3000',
        ],
        runInShell: true,
        includeParentEnvironment: true,
        mode: ProcessStartMode.detachedWithStdio);
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
    String compiled = await _compile();

    while (true) {
      Process process = await _startEdgeRuntime(
        compiled,
      );

      final watcher = DirectoryWatcher(p.join(Directory.current.path, 'lib'));
      Timer? _debounce;
      StreamSubscription? watcherSubscription;

      final completer = Completer();
      watcherSubscription = watcher.events.listen((event) async {
        if (_debounce?.isActive ?? false) _debounce?.cancel();
        _debounce = Timer(const Duration(milliseconds: 750), () {
          if (!completer.isCompleted) completer.complete();
        });
      });
      await completer.future;
      await watcherSubscription.cancel();
      compiled = await _compile();
      process.kill(ProcessSignal.sigterm);
    }
  }
}

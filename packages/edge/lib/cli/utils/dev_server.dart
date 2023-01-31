import 'dart:async';
import 'dart:io';
import 'package:cli_util/cli_logging.dart';
import 'package:edge/cli/utils/compiler.dart';
import 'package:typed_data/typed_buffers.dart';
import 'package:watcher/watcher.dart';
import 'package:path/path.dart' as p;

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
    while (true) {
      print('Starting....');
      Process process = await _startEdgeRuntime(
        await _compile(),
      );

      final watcher = DirectoryWatcher(p.join(Directory.current.path, 'lib'));
      // Timer? _debounce;
      StreamSubscription? watcherSubscription;

      final completer = Completer();
      watcherSubscription = watcher.events.listen((event) async {
        completer.complete();
      });
      await completer.future;
      await watcherSubscription.cancel();
      process.kill(ProcessSignal.sigkill);
      await process.stdout;
      await process.stderr;
      // print(await process.exitCode);
      await Future.delayed(Duration(milliseconds: 20000));
    }

    // Future<HotReloader> makeHotReloader() {
    //   return HotReloader.create(
    //     debounceInterval: Duration(milliseconds: 50),
    //     onAfterReload: (ctx) async {
    //       print('Stopping');
    //       await reloader!.stop();
    //       print('Stopped');
    //       process.kill();
    //       print(await process.exitCode);

    //       await Future.delayed(Duration(milliseconds: 2000));
    //       reloader = await makeHotReloader();
    //       print('Started');
    //     },
    //   );
    // }

    // reloader = await makeHotReloader();

    // await Future.delayed(Duration(seconds: 5));

    // // Works....
    // process.kill();

    // HotReloader? reloader;

    // final _ioSubscriptions = <StreamSubscription<List<int>>>[];
    // var output = Uint8Buffer();

    // void drainOutput(Stream<List<int>> stream) {
    //   try {
    //     _ioSubscriptions.add(stream.listen(output.addAll, cancelOnError: true));
    //   } on StateError catch (_) {}
    // }

    // try {
    //   reloader = await HotReloader.create(
    //     debounceInterval: Duration(milliseconds: 50),
    //     onAfterReload: (ctx) async {
    //       _ioSubscriptions.clear();
    //       output = Uint8Buffer();
    //       logger.write('Changes detected - restarting server...');
    //       try {
    //         exit(0);
    //       } catch (e) {
    //         print(e);
    //       } finally {
    //         print('in finally');
    //       }
    //       devServer.kill(ProcessSignal.sigkill);

    //       drainOutput(devServer.stdout);
    //       drainOutput(devServer.stderr);

    //       final code = await devServer.exitCode;
    //       await Future.delayed(Duration(milliseconds: 200));
    //       print('CODE $code');
    //       print(utf8.decode((output)));

    //       devServer = await _startEdgeRuntime(
    //         await _compile(),
    //       );
    //       logger.write('Server restarted');
    //     },
    //   );
    // } catch (e) {
    //   logger.write('Error - shutting down');
    //   logger.write(e.toString());
    //   await reloader?.stop();
    //   devServer.kill();
    //   exit(1);
    // }
  }
}

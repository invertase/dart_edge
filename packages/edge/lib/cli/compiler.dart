import 'dart:io';

import 'package:cli_util/cli_logging.dart';
import 'package:path/path.dart' as p;

import 'logger.dart';

enum CompilerLevel {
  O1,
  O2,
  O3,
  O4,
}

class Compiler {
  // The entry point of the application.
  final String entryPoint;

  // The output directory path.
  final String outputDirectory;

  final CompilerLevel level;

  // The output file name. Defaults to `main.dart.js`.
  final String outputFileName;

  Compiler({
    required this.entryPoint,
    required this.outputDirectory,
    required this.level,
    this.outputFileName = 'main.dart.js',
  });

  Future<String> compile() async {
    final entry = File(entryPoint);

    if (!await entry.exists()) {
      logger.error(
          'Attempted to compile the entry file at ${entry.path}, but no file was found.');
      logger.lineBreak();
      logger.hint(
          'Visit the docs for more information: https://docs.dartedge.dev');
      exit(1);
    }

    // final compiling = logger.progress('Compiling Dart entry point');

    final outputPath = p.join(outputDirectory, outputFileName);

    logger.verbose(
        'Compiling with optimization level ${level.name} ${entry.path} to $outputPath');

    final progress = logger.progress('Compiling Dart entry file');

    final process = await Process.run('dart', [
      'compile',
      'js',
      '-${level.name}',
      '--no-frequency-based-minification',
      '--server-mode',
      '-o',
      outputPath,
      entry.path,
    ]);

    if (process.exitCode != 0) {
      progress.cancel();
      logger.error('Compilation of the Dart entry file failed:');
      logger.lineBreak();
      logger.error(process.stdout);
      exit(1);
    }

    progress.finish(showTiming: true);
    logger.verbose(process.stdout);

    return outputPath;
  }
}

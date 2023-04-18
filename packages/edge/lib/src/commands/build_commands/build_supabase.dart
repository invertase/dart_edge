import 'dart:async';
import 'dart:io';

import 'package:edge/src/config.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:path/path.dart' as p;

import '../../compiler.dart';
import '../../watcher.dart';
import '../base_command.dart';

class SupabaseBuildCommand extends BaseCommand {
  @override
  final name = "supabase_functions";

  @override
  final description = "Builds the project for Supabase Edge Functions.";

  SupabaseBuildCommand({
    required super.logger,
  }) {
    argParser.addFlag(
      'dev',
      help:
          'Runs Dart Edge in a local development environment with hot reload via Vercel CLI.',
    );
    argParser.addOption(
      'project-path',
      abbr: 'p',
      help: 'The path to the supabase project.',
    );
    argParser.addFlag('verbose', abbr: 'v', help: 'Enables verbose logging.');
  }

  @override
  Future<Config> updateConfig(Config cfg) async {
    Config config = cfg.copyWith(
      supabase: cfg.supabase.copyWith(
        projectPath: p.canonicalize(argResults!.wasParsed('project-path')
            ? argResults!['project-path'] as String
            : cfg.supabase.projectPath),
      ),
    );

    logger.detail('Supabase project path: ${config.supabase.projectPath}');
    logger.detail('Supabase functions: ${config.supabase.functions}');
    return config;
  }

  Future<void> runDev() async {
    final cfg = await getConfig();

    final watcher = Watcher(
      include: '**/*.dart',
      debounce: 500,
      watchPath: p.join(Directory.current.path, 'lib'),
    );

    final compilers = <Compiler>[];
    final futures = <Future>[];
    final progress = logger.progress(
        'Compiling ' + cfg.supabase.functions.length.toString() + ' functions');
    for (final fn in cfg.supabase.functions.entries) {
      final fnDir = p.join(cfg.supabase.projectPath, 'functions', fn.key);
      final entryFile = File(p.join(fnDir, 'index.ts'));

      final compiler = Compiler(
        logger: logger,
        entryPoint: p.join(Directory.current.path, fn.value),
        outputDirectory: fnDir,
        outputFileName: 'main.dart.js',
        level: CompilerLevel.O1,
        fileName: fn.value,
        showProgress: false,
      );

      futures.add(compiler.compile());

      futures.add(entryFile.writeAsString(
        edgeFunctionEntryFileDefaultValue('main.dart.js'),
      ));

      compilers.add(compiler);
    }
    await Future.wait(futures);

    progress.complete();

    watcher.watch().listen((event) async {
      final progress = logger.progress(
        'Compiling ' + cfg.supabase.functions.length.toString() + ' functions',
      );
      await Future.wait(
        compilers.map((compiler) => compiler.compile()),
      );
      progress.complete();
    });
  }

  Future<void> runBuild() async {
    if (argResults!['verbose'] as bool) {
      logger.level = Level.verbose;
    }
    final cfg = await getConfig();

    for (final fn in cfg.supabase.functions.entries) {
      final fnDir = p.join(cfg.supabase.projectPath, 'functions', fn.key);
      final entryFile = File(p.join(fnDir, 'index.ts'));

      final compiler = Compiler(
        logger: logger,
        entryPoint: p.join(Directory.current.path, fn.value),
        outputDirectory: fnDir,
        outputFileName: 'main.dart.js',
        level: CompilerLevel.O4,
        fileName: fn.value,
      );

      await compiler.compile();

      await entryFile.writeAsString(
        edgeFunctionEntryFileDefaultValue('main.dart.js'),
      );
    }
  }

  @override
  void run() async {
    final isDev = argResults!['dev'] as bool;

    if (isDev) {
      await runDev();
    } else {
      await runBuild();
    }
  }
}

final edgeFunctionEntryFileDefaultValue = (String fileName) => '''
import { serve } from "https://deno.land/std@0.131.0/http/server.ts";
import "./${fileName}";

serve((request) => {
  if (self.__dartSupabaseFetchHandler) {
    return self.__dartSupabaseFetchHandler(request);
  }

  return new Response("Something went wrong", { status: 500 });
});

declare global {
  interface Window {
    __dartSupabaseFetchHandler?: (request: Request) => Promise<Response>;
  }
}
''';

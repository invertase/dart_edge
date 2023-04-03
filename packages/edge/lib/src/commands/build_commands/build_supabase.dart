import 'dart:io';

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
  }

  Future<void> runDev() async {
    final functionDirectory = Directory(
      p.join(Directory.current.path, 'supabase', 'functions', 'dart_edge'),
    );

    final entryFile = File(p.join(functionDirectory.path, 'index.ts'));

    final watcher = Watcher(
      include: '**/*.dart',
      debounce: 500,
      watchPath: p.join(Directory.current.path, 'lib'),
    );

    final compiler = Compiler(
      logger: logger,
      entryPoint: p.join(Directory.current.path, 'lib', 'main.dart'),
      outputDirectory: functionDirectory.path,
      outputFileName: 'main.dart.js',
      level: CompilerLevel.O1,
    );

    await compiler.compile();

    await entryFile.writeAsString(
      edgeFunctionEntryFileDefaultValue('main.dart.js'),
    );

    watcher.watch().listen((event) async {
      await compiler.compile();
    });
  }

  Future<void> runBuild() async {}

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

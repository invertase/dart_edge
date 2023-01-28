import 'dart:io';
import 'package:path/path.dart' as p;

import '../utils/compiler.dart';
import 'base_command.dart';

class CloudflareBuildCommand extends BaseCommand {
  @override
  final name = "cloudflare";

  @override
  final description = "TODO.";

  CloudflareBuildCommand() {
    argParser.addFlag(
      'dev',
      help:
          'Runs Dart Edge in a local development environment with hot reload via Vercel CLI.',
    );
  }

  @override
  void run() async {
    final tomlFile = File(p.join(Directory.current.path, 'wrangler.toml'));

    if (!await tomlFile.exists()) {
      logger.write('No wrangler.toml file found in the current directory.');
      exit(1);
    }

    // TODO: figure out how to get durable objects from toml

    final isDev = argResults!['dev'] as bool;

    final edgeTool = Directory(
      p.join(Directory.current.path, '.dart_tool', 'edge'),
    );

    final compiler = Compiler(
      logger: logger,
      entryPoint: p.join(Directory.current.path, 'lib', 'main.dart'),
      outputDirectory: edgeTool.path,
      outputFileName: 'main.dart.js',
      level: isDev ? CompilerLevel.O1 : CompilerLevel.O4,
    );

    await compiler.compile();

    // Update the entry file.
    await File(p.join(edgeTool.path, 'entry.js'))
        .writeAsString(edgeFunctionEntryFileDefaultValue('main.dart.js'));
  }
}

final edgeFunctionEntryFileDefaultValue =
    (String fileName) => '''import './${fileName}';

export default {
  fetch: (request, env, ctx) => {
    if (self.__dartFetchHandler !== undefined) {
      return self.__dartFetchHandler(request, env, ctx);
    }
  },
  scheduled: (event, env, ctx) => {
    if (self.__dartScheduledHandler !== undefined) {
      return self.__dartScheduledHandler(event, env, ctx);
    }
  },
  email: (message, env, ctx) => {
    if (self.__dartEmailHandler !== undefined) {
      return self.__dartEmailHandler(message, env, ctx);
    }
  },
};
''';

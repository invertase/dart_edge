import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:toml/toml.dart';

import '../compiler.dart';
import '../logger.dart';
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
      logger.error('No wrangler.toml file found in the current directory.');
      exit(1);
    }

    final toml = TomlDocument.parse(await tomlFile.readAsString()).toMap();

    final durableObjectBindings = toml['durable_objects']?['bindings'] ?? [];
    final Set<String> durableObjectNames = {
      for (final binding in durableObjectBindings)
        if (binding['class_name'] != null) binding['class_name']
    };

    final isDev = argResults!['dev'] as bool;

    final edgeTool = Directory(
      p.join(Directory.current.path, '.dart_tool', 'edge'),
    );

    final compiler = Compiler(
      entryPoint: p.join(Directory.current.path, 'lib', 'main.dart'),
      outputDirectory: edgeTool.path,
      outputFileName: 'main.dart.js',
      level: isDev ? CompilerLevel.O1 : CompilerLevel.O4,
    );

    await compiler.compile();

    String entryFile = edgeFunctionEntryFileDefaultValue('main.dart.js');

    logger.verbose('Generating Durable Object exports: $durableObjectNames');

    // Add durable objects as exports.
    for (final durableObjectName in durableObjectNames) {
      entryFile += edgeFunctionDurableObjectValue(durableObjectName);
    }

    // Update the entry file.
    await File(p.join(edgeTool.path, 'entry.js')).writeAsString(entryFile);
  }
}

final edgeFunctionEntryFileDefaultValue =
    (String fileName) => '''import './${fileName}';

export default {
  fetch: (request, env, ctx) => {
    if (self.__dartCloudflareFetchHandler !== undefined) {
      return self.__dartCloudflareFetchHandler(request, env, ctx);
    }
  },
  scheduled: (event, env, ctx) => {
    if (self.__dartCloudflareScheduledHandler !== undefined) {
      return self.__dartCloudflareScheduledHandler(event, env, ctx);
    }
  },
  email: (message, env, ctx) => {
    if (self.__dartCloudflareEmailHandler !== undefined) {
      return self.__dartCloudflareEmailHandler(message, env, ctx);
    }
  },
};

''';

final edgeFunctionDurableObjectValue = (String className) => '''
export class $className {
  constructor(state, env) {
    const instance = self.__dartCloudflareDurableObjects["$className"];

    if (!instance) {
      throw new Error(
        `No Dart Durable object instance named '$className' found.`
      );
    }

    this.delegate = instance(state, env);
  }

  fetch(request) {
    return this.delegate.fetch(request);
  }

  alarm() {
    return this.delegate.alarm();
  }
}
''';

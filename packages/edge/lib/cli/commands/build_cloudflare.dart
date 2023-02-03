import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:toml/toml.dart';

import '../compiler.dart';
import '../logger.dart';
import 'base_command.dart';

class CloudflareBuildCommand extends BaseCommand {
  @override
  final name = "cloudflare_workers";

  @override
  final description =
      "Builds a Dart Edge project for the Cloudflare Workers environment.";

  CloudflareBuildCommand() {
    argParser.addFlag(
      'dev',
      help:
          'Compiles Dart code with low levels of minification, for faster compilation but less performant code.',
    );
  }

  @override
  void run() async {
    final tomlFile = File(p.join(Directory.current.path, 'wrangler.toml'));

    if (!await tomlFile.exists()) {
      logger.error('No wrangler.toml exists in the current directory.');
      logger.lineBreak();
      logger.hint(
        'To get started with Cloudflare Workers, vist the docs: https://docs.dartedge.dev/platform/cloudflare',
      );
      exit(1);
    }

    Map<String, dynamic> toml;

    try {
      toml = TomlDocument.parse(await tomlFile.readAsString()).toMap();
    } catch (e) {
      logger.error('Failed to parse wrangler.toml file.');
      exit(1);
    }

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
    
    // Add durable objects as exports.
    for (final durableObjectName in durableObjectNames) {
      entryFile += edgeFunctionDurableObjectValue(durableObjectName);
    }

    if (durableObjectNames.isNotEmpty) {
    logger.verbose('Creating Durable Object exports: $durableObjectNames');
    }

    // Update the entry file.
    await File(p.join(edgeTool.path, 'entry.js')).writeAsString(entryFile);

    logger.verbose(
      'Entry file generated at ${p.join(edgeTool.path, 'entry.js')}',
    );
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

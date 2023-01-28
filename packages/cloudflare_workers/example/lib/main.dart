import 'package:cloudflare_workers/cloudflare_workers.dart';

void main() {
  CloudflareWorkers(
    fetch: (request, env, ctx) async {
      if (request.method == 'GET') {
        return Response('Hello World :D');
      }

      print(request.headers['content-type']);

      final formData = await request.formData();

      // final string = formData.get('string');
      // string?.maybeWhen(
      //   string: (value) => print(value),
      //   orElse: () {
      //     throw StateError('Expected string');
      //   },
      // );

      final file = formData.get('file');
      file?.maybeWhen(
        file: (value) async {
          print(value.name);
          print(value.lastModified);
          print(value.webkitRelativePath);
          print(await value.text());
          print(await value.slice());
          print(await value.arrayBuffer());
        },
        orElse: () {
          throw StateError('Expected file');
        },
      );

      return Response('Hello World :D');
    },
    scheduled: (event, env, ctx) {
      // ScheduledEvent!!
    },
    email: (message, env, ctx) {
      // Email Message!!
    },
  );
}

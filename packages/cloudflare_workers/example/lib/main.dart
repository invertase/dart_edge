import 'package:cloudflare_workers/cloudflare_workers.dart';

void main() {
  CloudflareWorkers(
    fetch: (request, env, ctx) async {
      if (request.url.toString().contains('favicon.ico')) {
        return Response('');
      }

      try {
        final r = await fetch(Resource('https://dummyjson.com/products/1'));
        print('got response');
        print(r.ok);
        final j = await r.json() as dynamic;
        print(j);
        for (final p in j['images']) {
          print(p);
        }
      } catch (e) {
        print('ERROR');
        print(e);
      }

      return Response('Hello World!');
    },
    scheduled: (event, env, ctx) {
      // ScheduledEvent!!
    },
    email: (message, env, ctx) {
      // Email Message!!
    },
  );
}

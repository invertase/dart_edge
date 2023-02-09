import 'package:cloudflare_workers/cloudflare_workers.dart';

void main() {
  CloudflareWorkers(
    fetch: (request, env, ctx) async {
      final cache = caches.defaultCache;
      final request = Request(Resource('foo'));

      await cache.put(
        request,
        Response(
          'bar',
          headers: Headers(
            {
              'cache-control': 'max-age=1234',
            },
          ),
        ),
      );
      
      return (await cache.match(request) ?? Response('not found'));
    },
  );
}

import 'package:test/test.dart';

import 'utils.dart';

void main() {
  test('it can access the default cache storage', () async {
    final mf = await runOnMiniflare('''
CloudflareWorkers(
  fetch: (request, env, ctx) async {
    final cache = caches.defaultCache;
    final request = Request(Resource('https://example.com'));

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
''');

    final response = await mf.dispatchFetch();

    expect(response.ok, true);
    expect(await response.text(), 'bar');
  });
}

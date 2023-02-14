import 'package:test/test.dart';

import 'utils.dart';

void main() {
  group('KV', () {
    test('it errors when a namespace does not exist', () async {
      final mf = await runOnMiniflare('''
CloudflareWorkers(
  fetch: (request, env, ctx) async {
    try {
      env.getKVNamespace('foo');
      return Response(null, status: 500);
    } catch (e) {
      return Response(null, status: 200);
    }
  },
);
''');

      final response = await mf.dispatchFetch();
      expect(response.ok, true);
    });

    group('get()', () {
      test('it returns null when a value does not exist', () async {
        final mf = await runOnMiniflare('''
CloudflareWorkers(
  fetch: (request, env, ctx) async {
    try {
      final KV = env.getKVNamespace('TEST_KV');
      return Response(await KV.get('foo'), status: 200);
    } catch (e) {
      return Response(null, status: 500);
    }
  },
);
''');

        final response = await mf.dispatchFetch();
        expect(response.ok, true);
        expect(response.body, isNull);
      });

      test('it returns a string when a value when it exists', () async {
        final mf = await runOnMiniflare('''
CloudflareWorkers(
  fetch: (request, env, ctx) async {
    try {
      final KV = env.getKVNamespace('TEST_KV');
      await KV.put('foo', 'bar');
      return Response(await KV.get('foo'), status: 200);
    } catch (e) {
      return Response(null, status: 500);
    }
  },
);
''');

        final response = await mf.dispatchFetch();
        expect(response.ok, true);
        expect(await response.text(), 'bar');
      });
    });

    group('getWithMetadata()', () {
      test('it returns null when a value does not exist', () async {
        final mf = await runOnMiniflare('''
CloudflareWorkers(
  fetch: (request, env, ctx) async {
    try {
      final KV = env.getKVNamespace('TEST_KV');
      final res = await KV.getWithMetadata('foo');
      return Response(res.value, status: 200);
    } catch (e) {
      return Response(null, status: 500);
    }
  },
);
''');

        final response = await mf.dispatchFetch();
        expect(response.ok, true);
        expect(response.body, isNull);
      });

      test('it returns null metadata when a value does not exist', () async {
        final mf = await runOnMiniflare('''
CloudflareWorkers(
  fetch: (request, env, ctx) async {
    try {
      final KV = env.getKVNamespace('TEST_KV');
      final res = await KV.getWithMetadata('foo');
      return Response(res.metadata, status: 200);
    } catch (e) {
      return Response(e.toString(), status: 500);
    }
  },
);
''');

        final response = await mf.dispatchFetch();
        expect(response.ok, true);
        expect(response.body, isNull);
      });
    });
  });
}

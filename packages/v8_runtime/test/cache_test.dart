import 'package:test/test.dart';
import 'package:v8_runtime/v8_runtime.dart';

import 'utils.dart';

void main() {
  group('CacheStorage', () {
    test('caches', () {
      final cache = caches;
      expect(cache, isNotNull);
    });

    test('.has()', () async {
      await caches.open('exists');

      expect(await caches.has('does-not-exist'), isFalse);
      expect(await caches.has('exists'), isTrue);
    });

    test('.delete()', () async {
      await caches.open('exists');
      expect(await caches.has('exists'), isTrue);
      await caches.delete('exists');
      expect(await caches.has('exists'), isFalse);
    });

    // TODO: keys() api not working
    // test('.keys()', () async {
    //   await caches.open('one');
    //   await caches.open('two');
    //   expect(await caches.keys(), ['one', 'two']);
    // });

    test('.match()', () async {
      final request = Request(Resource('https://foo.com'));
      final response = Response('foo');

      expect(await caches.match(request), isNull);
      final cache = await caches.open('match');
      await cache.put(request, response);
      final match = await caches.match(request);
      expect(match, isNotNull);
      expect(await match!.text(), 'foo');
    });
  });
}

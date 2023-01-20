import 'dart:convert';

import 'package:fetch_apis/fetch_apis.dart';

void main() {
  addFetchEventListener((FetchEvent event) {
    event.respondWith(Future(() async {
      final url = Uri.https(
        'dummyjson.com',
        '/quotes/random',
      );

      try {
        final cachedResponse = await caches.defaultCache.match(url);
        if (cachedResponse != null) {
          print('Using cached response');
          return cachedResponse;
        }

        final fetchResponse = await fetch(Resource(url.toString()));
        final buffer = await fetchResponse.arrayBuffer();
        final response = Response(buffer);
        print(Utf8Decoder().convert(buffer.asUint8List()));
        await caches.defaultCache.put(url, response.clone());
        return response.clone();
      } catch (e, s) {
        print(s);
        print(e);
        return Response('ERROR $e $s');
      }
    }));
  });
}

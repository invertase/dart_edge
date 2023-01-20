import 'dart:convert';

import 'package:fetch_apis/fetch_apis.dart';

const shouldUseCache = true;

void main() {
  addFetchEventListener((FetchEvent event) {
    event.respondWith(Future(() async {
      if (event.request.url.contains('favicon.ico')) {
        return Response('Not found', status: 404);
      }

      final url = Uri.https(
        'dummyjson.com',
        '/quotes/random',
      );

      try {
        final cachedResponse = await caches.defaultCache.match(url);
        if (shouldUseCache && cachedResponse != null) {
          print('Using cached response');
          return cachedResponse;
        }

        final fetchResponse = await fetch(Resource.uri(url));
        final buffer = await fetchResponse.arrayBuffer();
        final headers = Headers({
          'content-type': 'application/json',
          'x-foo': 'bar',
        });
        final response = Response(buffer, headers: headers);

        // Make sure we can decode the response ourselves.
        print(Utf8Decoder().convert(buffer.asUint8List()));

        if (shouldUseCache) {
          await caches.defaultCache.put(url, response.clone());
        }
        return response;
      } catch (e, s) {
        print(s);
        print(e);
        return Response('ERROR $e $s');
      }
    }));
  });
}

import 'package:fetch_apis/fetch_apis.dart';

const shouldUseCache = true;

void main() {
  addFetchEventListener((FetchEvent event) {
    event.respondWith(Future(() async {
      if (event.request.url.toString().contains('favicon.ico')) {
        return Response(
          'Not found',
          ResponseInit(status: 404),
        );
      }

      return HTMLRewriter().on('h1', ElemetHandler(
        element: (element) {
          print('GOT H1 ELEMENT!');
          print(element.tagName);
          element.replace(
              '<h1>Heh, not bad. <b>:D</b></h1>', ContentOptions(html: true));
        },
      )).onDocument(DocumentHandler(
        comments: (comment) {
          print('GOT COMMENT!');
          print(comment.text);
          comment.text = 'This is a modified comment';
        },
      )).transform(
        Response(
          '''<!DOCTYPE html>
<html>
  <head>
    <title>My First Cloudflare Workers Site</title>
  </head>
  <body>
    <h1>Hello, World!</h1>
    <!-- This is a comment -->
    <p>I'm hosted with Cloudflare Workers</p>
  </body>
</html>
''',
          ResponseInit(
            headers: Headers({'content-type': 'text/html'}),
          ),
        ),
      );

      // if (event.request.url.toString().contains('favicon.ico')) {
      //   return Response(
      //     'Not found',
      //     ResponseInit(status: 404),
      //   );
      // }

      // final url = Uri.https(
      //   'dummyjson.com',
      //   '/quotes/random',
      // );

      // try {
      //   final cachedResponse =
      //       await caches.defaultCache.match(Resource.uri(url));
      //   if (shouldUseCache && cachedResponse != null) {
      //     print('Using cached response');
      //     return cachedResponse;
      //   }

      //   final fetchResponse = await fetch(Resource.uri(url));
      //   final buffer = await fetchResponse.arrayBuffer();
      //   final headers = Headers({
      //     'content-type': 'application/json',
      //     'x-foo': 'bar',
      //   });
      //   final response = Response(
      //     buffer,
      //     ResponseInit(headers: headers),
      //   );

      //   // Make sure we can decode the response ourselves.
      //   print(Utf8Decoder().convert(buffer.asUint8List()));

      //   if (shouldUseCache) {
      //     await caches.defaultCache.put(Resource.uri(url), response.clone());
      //   }
      //   return response;
      // } catch (e, s) {
      //   print(s);
      //   print(e);
      //   return Response('ERROR $e $s');
      // }
    }));
  });
}

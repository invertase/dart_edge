import 'dart:convert';

import 'package:fetch_apis/fetch_apis.dart';

void main() {
  addFetchEventListener((FetchEvent event) {
    print('YOLO');
    event.respondWith(Future(() async {
      // This example will fetch a random quote from the
      // dummyjson.com service...
      final url = Uri.https(
        'dummyjson.com',
        '/quotes/random',
      );

      final response = await fetch(Resource(url.toString()));
      final buffer = await response.arrayBuffer();
      print(Utf8Decoder().convert(buffer.asUint8List()));
      return Response(buffer);
    }));
  });
  // addFetchEventListener((FetchEvent event) {
  //   event.respondWith(Response('hello-mike'));
  // });
}

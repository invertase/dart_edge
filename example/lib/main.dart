import 'package:fetch_apis/fetch_apis.dart';

void main() {
  addFetchEventListener((FetchEvent event) {
    event.respondWith(Future(() async {
      // This example will fetch a random quote from the
      // dummyjson.com service...
      final url = Uri.https(
        'dummyjson.com',
        '/quotes/random',
      );

      final response = await fetch(url);
      print(await response.json());
      return Response('hello-mike');
    }));
  });
}

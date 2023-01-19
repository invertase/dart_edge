import 'fetch_api.dart';

void main() {
  // Alternative none stream syntax:
  addFetchEventListener((FetchEvent event) {
    event.respondWith(Future(() async {
      await Future.delayed(Duration(seconds: 1));
      return Response('hello-mike');
    }));
  });
}

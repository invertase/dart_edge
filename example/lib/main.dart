import 'fetch_api.dart';

void main() {
  onFetch.where((event) => event.request.url.endsWith('/mike')).listen((event) {
    event.respondWith(Response('hello-mike'));
  });

  onFetch
      .where((event) => event.request.url.endsWith('/elliot'))
      .listen((event) {
    event.respondWith(Response('hello-elliot'));
  });

  onFetch.listen((event) {
    print(event.request.url);
    event.respondWith(Response('I don\'t know you'));
  });

  // Alternative none stream syntax:
  //   addFetchEventListener((FetchEvent event) {
  //     print(event.request.url);
  //     if (event.request.url.endsWith('/elliot')) {
  //       event.respondWith(Response('hello-elliot'));
  //     } else if (event.request.url.endsWith('/mike')) {
  //       event.respondWith(Response('hello-mike'));
  //     } else {
  //       event.respondWith(Response('I don\'t know you'));
  //     }
  //   });
}

import 'package:edge/runtime.dart';

void main() {
  // Setup the runtime environment.
  setupRuntime();

  // Register a fetch event listener.
  addFetchEventListener((event) {
    final request = event.request;

    // Ignore browser favicon requests.
    if (request.url.toString().contains('favicon')) {
      event.respondWith(Response(''));
    }

    event.respondWith(fetchHandler(request));
  });
}

/// A fetch event handler.
Future<Response> fetchHandler(Request request) async {
  return Response('Hello, world!!', status: 200);
}

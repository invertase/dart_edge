import 'package:edge_runtime/edge_runtime.dart';
import 'package:http/http.dart' as http;

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
  print('do request');
  final r =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos/1'));
  print(r.body);

  return Response('Hello, world!!', status: 200);
}

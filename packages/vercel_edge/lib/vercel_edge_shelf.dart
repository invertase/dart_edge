import 'package:js/js.dart';
import 'package:edge_runtime/edge_runtime.dart';
import 'dart:js_util' as js_util;
import 'package:js_bindings/js_bindings.dart' as interop;
import 'package:shelf/shelf.dart' as shelf;
import 'package:edge_runtime/src/interop/promise_interop.dart';
import 'package:edge_runtime/src/response.dart';

@JS('__dartVercelFetchHandler')
external set __dartVercelFetchHandler(
    Promise<interop.Response> Function(interop.Request req) f);

class VercelEdgeShelf {
  final FutureOr<shelf.Response> Function(shelf.Request request)? fetch;

  VercelEdgeShelf({
    this.fetch,
  }) {
    // Setup the runtime environment.
    setupRuntime();

    if (fetch != null) {
      __dartVercelFetchHandler = allowInterop((interop.Request request) {
        return futureToPromise(Future(() async {
          final clone = request.clone();

          final Map<String, String> headers = {};

          js_util.callMethod(request.headers, 'forEach', [
            allowInterop((value, key, _) {
              headers[key] = value;
            })
          ]);

          final reader = clone.body?.getReader();
          final body = reader != null ? streamFromJSReader(reader) : null;

          final shelfRequest = shelf.Request(
            clone.method,
            Uri.parse(clone.url),
            body: body,
            headers: headers,
          );

          final response = await fetch!(shelfRequest);

          return Response(
            await response.readAsString(),
            status: response.statusCode,
            headers: Headers(response.headers),
          ).delegate;
        }));
      });
    }
  }
}

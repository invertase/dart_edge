import 'package:edge/runtime/response.dart';
import 'package:js/js.dart';
import 'package:edge/runtime.dart';
import 'dart:js_util' as js_util;
import 'package:js_bindings/js_bindings.dart' as interop;
import 'package:shelf/shelf.dart' as shelf;
import 'package:edge/runtime/interop/promise_interop.dart';

@JS('__dartFetchHandler')
external set __dartFetchHandler(
    Promise<interop.Response> Function(interop.Request req) f);

class VercelEdgeShelf {
  final FutureOr<shelf.Response> Function(shelf.Request request)? fetch;

  VercelEdgeShelf({
    this.fetch,
  }) {
    if (fetch != null) {
      __dartFetchHandler = allowInterop((interop.Request request) {
        return futureToPromise(Future(() async {
          final clone = request.clone();

          final Map<String, String> headers = {};

          js_util.callMethod(request.headers, 'forEach', [
            allowInterop((value, key, _) {
              headers[key] = value;
            })
          ]);

          final shelfRequest = shelf.Request(
            clone.method,
            Uri.parse(clone.url),
            body: clone.body,
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

import 'dart:js_util' as js_util;

import 'package:edge_runtime/edge_runtime.dart';
import 'package:edge_runtime/src/interop/promise_interop.dart';
import 'package:edge_runtime/src/response.dart';
import 'package:js/js.dart';
import 'package:js_bindings/js_bindings.dart' as interop;
import 'package:shelf/shelf.dart' as shelf;

export 'package:deno_deploy/deno_deploy.dart' hide Response;

@JS('__dartSupabaseFetchHandler')
external set __dartSupabaseFetchHandler(
    Promise<interop.Response> Function(interop.Request req) f);

class SupabaseFunctionsShelf {
  final FutureOr<shelf.Response> Function(shelf.Request request)? fetch;

  SupabaseFunctionsShelf({
    this.fetch,
  }) {
    // Setup the runtime environment.
    setupRuntime();

    if (fetch != null) {
      __dartSupabaseFetchHandler = allowInterop((interop.Request request) {
        return futureToPromise(Future(() async {
          final clone = request.clone();
          final Map<String, String> headers = {};

          js_util.callMethod(request.headers, 'forEach', [
            allowInterop((value, key, _) {
              headers[key] = value;
            })
          ]);

          // Remove the first path segment, because it starts with `dart_edge/<actual-sub-path>`.
          var uri = Uri.parse(clone.url);
          uri = uri.replace(pathSegments: uri.pathSegments.skip(1));
          if (uri.path.isEmpty) {
            uri = uri.replace(path: "/");
          }

          final shelfRequest = shelf.Request(
            clone.method,
            uri,
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

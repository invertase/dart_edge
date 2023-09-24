import 'package:js/js.dart';
import 'package:edge_runtime/edge_runtime.dart';
import 'package:edge_runtime/src/interop/promise_interop.dart';
import 'package:edge_runtime/src/response.dart';
import 'package:typings/core.dart' as interop;

export 'package:edge_runtime/edge_runtime.dart';
export 'package:deno_deploy/deno_deploy.dart';

@JS('__dartSupabaseFetchHandler')
external set __dartSupabaseFetchHandler(Promise<interop.Response> Function(interop.Request req) f);

class SupabaseFunctions {
  final FutureOr<Response> Function(interop.Request request)? fetch;

  SupabaseFunctions({
    this.fetch,
  }) {
    // Setup the runtime environment.
    setupRuntime();

    if (fetch != null) {
      __dartSupabaseFetchHandler = allowInterop((interop.Request request) {
        return futureToPromise(Future(() async {
          final response = await fetch!(request);
          return response.delegate;
        }));
      });
    }
  }
}

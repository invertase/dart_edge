import 'package:js/js.dart';
import 'package:netlify_edge/public/context.dart';
import 'package:edge/runtime/interop/promise_interop.dart';
import 'package:edge/runtime.dart';
import 'package:edge/runtime/request.dart';
import 'package:edge/runtime/response.dart';
import 'package:js_bindings/js_bindings.dart' as interop;
import 'interop/context_interop.dart' as interop;

export 'package:edge/runtime.dart';
export './public/context.dart' hide netlifyContextFromJsObject;

@JS('__dartNetlifyFetchHandler')
external set __dartNetlifyFetchHandler(
    Promise<interop.Response> Function(
            interop.Request req, interop.NetlifyContext)
        f);

class NetlifyEdge {
  final FutureOr<Response> Function(Request request, NetlifyContext context)?
      fetch;

  NetlifyEdge({
    this.fetch,
  }) {
    // Setup the runtime environment.
    setupRuntime();

    if (fetch != null) {
      __dartNetlifyFetchHandler =
          allowInterop((interop.Request req, interop.NetlifyContext context) {
        return futureToPromise(Future(() async {
          final response = await fetch!(
            requestFromJsObject(req),
            netlifyContextFromJsObject(context),
          );
          return response.delegate;
        }));
      });
    }
  }
}

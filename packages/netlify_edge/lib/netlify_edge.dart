import 'package:js/js.dart';
import 'package:netlify_edge/public/context.dart';
import 'package:v8_runtime/interop/promise_interop.dart';
import 'package:v8_runtime/v8_runtime.dart';
import 'package:v8_runtime/public/request.dart';
import 'package:v8_runtime/public/response.dart';
import 'package:js_bindings/js_bindings.dart' as interop;
import 'interop/context_interop.dart' as interop;

export 'package:v8_runtime/v8_runtime.dart';
export './public/context.dart' hide netlifyContextFromJsObject;

@JS('__dartFetchHandler')
external set __dartFetchHandler(
    Promise<interop.Response> Function(
            interop.Request req, interop.NetlifyContext)
        f);

class NetlifyEdge {
  final FutureOr<Response> Function(Request request, NetlifyContext context)?
      fetch;

  NetlifyEdge({
    this.fetch,
  }) {
    if (fetch != null) {
      __dartFetchHandler =
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

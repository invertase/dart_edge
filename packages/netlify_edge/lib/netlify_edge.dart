import 'package:js/js.dart';
import 'package:v8_runtime/interop/promise_interop.dart';
import 'package:v8_runtime/v8_runtime.dart';
import 'package:v8_runtime/public/request.dart';
import 'package:v8_runtime/public/response.dart';
import 'package:js_bindings/js_bindings.dart' as interop;

export 'package:v8_runtime/v8_runtime.dart';

@JS('__dartFetchHandler')
external set __dartFetchHandler(
    Promise<interop.Response> Function(interop.Request req) f);

class NetlifyEdge {
  final FutureOr<Response> Function(Request event)? fetch;

  NetlifyEdge({
    this.fetch,
  }) {
    if (fetch != null) {
      __dartFetchHandler = allowInterop((interop.Request req) {
        return futureToPromise(Future(() async {
          final response = await fetch!(requestFromJsObject(req));
          return response.delegate;
        }));
      });
    }
  }
}

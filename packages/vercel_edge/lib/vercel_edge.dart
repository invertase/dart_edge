import 'package:js/js.dart';
import 'package:edge/runtime.dart';
import 'package:edge/runtime/interop/promise_interop.dart';
import 'package:edge/runtime/request.dart';
import 'package:edge/runtime/response.dart';
import 'package:js_bindings/js_bindings.dart' as interop;

export 'package:edge/runtime.dart';
export './public/request.dart';

@JS('__dartFetchHandler')
external set __dartFetchHandler(
    Promise<interop.Response> Function(interop.Request req) f);

class VercelEdge {
  final FutureOr<Response> Function(Request request)? fetch;

  VercelEdge({
    this.fetch,
  }) {
    if (fetch != null) {
      __dartFetchHandler = allowInterop((interop.Request request) {
        return futureToPromise(Future(() async {
          final response = await fetch!(requestFromJsObject(request));
          return response.delegate;
        }));
      });
    }
  }
}

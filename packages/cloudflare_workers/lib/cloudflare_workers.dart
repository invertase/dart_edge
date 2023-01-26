import 'dart:js_util' as js_util;

import 'package:js/js.dart';
import 'package:v8_runtime/interop/promise_interop.dart';
import 'package:v8_runtime/v8_runtime.dart';
import 'package:v8_runtime/public/request.dart';
import 'package:v8_runtime/public/response.dart';
import 'package:js_bindings/js_bindings.dart' as interop;
import 'interop/execution_context_interop.dart' as interop;
import './public/execution_context.dart';
import './public/environment.dart';

import 'public/durable_object.dart';

export 'package:v8_runtime/v8_runtime.dart';

export './public/cache_storage.dart';
export './public/durable_object.dart';
export './public/html_rewriter.dart'
    show
        HTMLRewriter,
        ContentOptions,
        ElementHandler,
        DocumentHandler,
        Doctype,
        Comment,
        Text,
        DocumentEnd,
        Element,
        EndTag;
export './public/request.dart';

@JS('__dartFetchHandler')
external set __dartFetchHandler(
    Promise<interop.Response> Function(
            interop.Request req, dynamic env, interop.ExecutionContext ctx)
        f);

@JS('__durableObjects')
external set __durableObjects(dynamic value);

class CloudflareWorkers {
  final Iterable<DurableObject>? durableObjects;

  final FutureOr<Response> Function(
      Request event, Environment env, ExecutionContext ctx)? fetch;

  CloudflareWorkers({
    this.fetch,
    this.durableObjects,
  }) {
    // Attach the fetch handler to the global object.
    if (fetch != null) {
      __dartFetchHandler = allowInterop(
          (interop.Request req, dynamic env, interop.ExecutionContext ctx) {
        return futureToPromise(Future(() async {
          final response = await fetch!(
            requestFromJsObject(req),
            environmentFromJsObject(env),
            executionContextFromJsObject(ctx),
          );
          return response.delegate;
        }));
      });
    }

    // Attach the durable objects to the global object, by name.
    if (durableObjects != null) {
      __durableObjects = js_util.jsify({
        for (final instance in durableObjects!)
          instance.name: instance.delegate
            ..fetch = allowInterop((fetchObj) {
              return futureToPromise(Future(() async {
                final r = await instance.fetch(requestFromJsObject(fetchObj));
                return r.delegate;
              }));
            })
            ..init = allowInterop(instance.init)
      });
    }
  }
}

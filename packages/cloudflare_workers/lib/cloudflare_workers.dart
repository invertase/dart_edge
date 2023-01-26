import 'dart:js_util' as js_util;

import 'package:cloudflare_workers/public/scheduled_event.dart';
import 'package:js/js.dart';
import 'package:v8_runtime/interop/promise_interop.dart';
import 'package:v8_runtime/v8_runtime.dart';
import 'package:v8_runtime/public/request.dart';
import 'package:v8_runtime/public/response.dart';
import 'package:js_bindings/js_bindings.dart' as interop;
import 'interop/environment_interop.dart' as interop;
import 'interop/scheduled_event_intertop.dart' as interop;
import 'interop/execution_context_interop.dart' as interop;
import './public/execution_context.dart';
import './public/environment.dart';
import './public/scheduled_event.dart';

import 'public/do/durable_object.dart';

export 'package:v8_runtime/v8_runtime.dart';

export './public/cache_storage.dart';
export './public/do/durable_object_id.dart' show DurableObjectId;
export './public/do/durable_object_namespace.dart' show DurableObjectNamespace;
export './public/do/durable_object.dart' show DurableObject;
export './public/do/durable_object_state.dart' show DurableObjectState;
export './public/do/durable_object_storage.dart' show DurableObjectStorage;
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
    Promise<interop.Response> Function(interop.Request req,
            interop.Environment env, interop.ExecutionContext ctx)
        f);

@JS('__dartScheduledHandler')
external set __dartScheduledHandler(
    Promise<void> Function(interop.ScheduledEvent event,
            interop.Environment env, interop.ExecutionContext ctx)
        f);

@JS('__durableObjects')
external set __durableObjects(dynamic value);

class CloudflareWorkers {
  final Iterable<DurableObject>? durableObjects;

  final FutureOr<Response> Function(
      Request event, Environment env, ExecutionContext ctx)? fetch;

  final FutureOr<void> Function(
      ScheduledEvent event, Environment env, ExecutionContext ctx)? scheduled;

  CloudflareWorkers({
    this.fetch,
    this.scheduled,
    this.durableObjects,
  }) {
    // Attach the fetch handler to the global object.
    if (fetch != null) {
      __dartFetchHandler = allowInterop((interop.Request req,
          interop.Environment env, interop.ExecutionContext ctx) {
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

    // Attach the scheduled handler to the global object.
    if (scheduled != null) {
      __dartScheduledHandler = allowInterop((interop.ScheduledEvent event,
          interop.Environment env, interop.ExecutionContext ctx) {
        return futureToPromise(Future(() async {
          return scheduled!(
            scheduledEventFromJsObject(event),
            environmentFromJsObject(env),
            executionContextFromJsObject(ctx),
          );
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

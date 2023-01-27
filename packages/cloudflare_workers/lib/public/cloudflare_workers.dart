import 'dart:js_util' as js_util;

import 'package:js/js.dart';
import 'package:v8_runtime/interop/promise_interop.dart';
import 'package:v8_runtime/v8_runtime.dart';
import 'package:v8_runtime/public/request.dart';
import 'package:v8_runtime/public/response.dart';

import 'package:js_bindings/js_bindings.dart' as interop;
import '../interop/environment_interop.dart' as interop;
import '../interop/scheduled_event_interop.dart' as interop;
import '../interop/email_message_interop.dart' as interop;
import '../interop/execution_context_interop.dart' as interop;

import '../public/execution_context.dart';
import '../public/scheduled_event.dart';
import '../public/email_message.dart';
import '../public/environment.dart';
import '../public/do/durable_object.dart';

@JS('__dartFetchHandler')
external set globalDartFetchHandler(
    Promise<interop.Response> Function(interop.Request req,
            interop.Environment env, interop.ExecutionContext ctx)
        f);

@JS('__dartScheduledHandler')
external set globalDartScheduledHandler(
    Promise<void> Function(interop.ScheduledEvent event,
            interop.Environment env, interop.ExecutionContext ctx)
        f);

@JS('__dartEmailHandler')
external set globalDartEmailHandler(
    Promise<void> Function(interop.EmailMessage message,
            interop.Environment env, interop.ExecutionContext ctx)
        f);

@JS('__durableObjects')
external set globalDurableObjects(dynamic value);

typedef CloudflareWorkersFetchEvent = FutureOr<Response> Function(
    Request request, Environment env, ExecutionContext ctx);

typedef CloudflareWorkersScheduledEvent = FutureOr<void> Function(
    ScheduledEvent event, Environment env, ExecutionContext ctx);

typedef CloudflareWorkersEmailEvent = FutureOr<void> Function(
    EmailMessage message, Environment env, ExecutionContext ctx);

void attachFetchHandler(CloudflareWorkersFetchEvent handler) {
  globalDartFetchHandler = allowInterop((interop.Request req,
      interop.Environment env, interop.ExecutionContext ctx) {
    return futureToPromise(Future(() async {
      final response = await handler(
        requestFromJsObject(req),
        environmentFromJsObject(env),
        executionContextFromJsObject(ctx),
      );
      return response.delegate;
    }));
  });
}

void attachScheduledHandler(CloudflareWorkersScheduledEvent handler) {
  globalDartScheduledHandler = allowInterop((interop.ScheduledEvent event,
      interop.Environment env, interop.ExecutionContext ctx) {
    return futureToPromise(Future(() async {
      return handler(
        scheduledEventFromJsObject(event),
        environmentFromJsObject(env),
        executionContextFromJsObject(ctx),
      );
    }));
  });
}

void attachEmailHandler(CloudflareWorkersEmailEvent handler) {
  globalDartEmailHandler = allowInterop((interop.EmailMessage message,
      interop.Environment env, interop.ExecutionContext ctx) {
    return futureToPromise(Future(() async {
      return handler(
        emailMessageFromJsObject(message),
        environmentFromJsObject(env),
        executionContextFromJsObject(ctx),
      );
    }));
  });
}

void attachDurableObjects(Iterable<DurableObject> instances) {
  globalDurableObjects = js_util.jsify({
    for (final instance in instances)
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

class CloudflareWorkers {
  final Iterable<DurableObject>? durableObjects;

  final CloudflareWorkersFetchEvent? fetch;

  final CloudflareWorkersScheduledEvent? scheduled;

  final CloudflareWorkersEmailEvent? email;

  CloudflareWorkers({
    this.fetch,
    this.scheduled,
    this.email,
    this.durableObjects,
  }) {
    // Attach the fetch handler to the global object.
    if (fetch != null) {
      attachFetchHandler(fetch!);
    }

    // Attach the scheduled handler to the global object.
    if (scheduled != null) {
      attachScheduledHandler(scheduled!);
    }

    // Attach the email handler to the global object.
    if (email != null) {
      attachEmailHandler(email!);
    }

    // Attach the durable objects to the global object, by name.
    if (durableObjects != null) {
      attachDurableObjects(durableObjects!);
    }
  }
}

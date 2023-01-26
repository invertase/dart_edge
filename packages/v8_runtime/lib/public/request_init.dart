import 'package:js_bindings/js_bindings.dart' as interop;

import 'abort_signal.dart';
import 'headers.dart';

class RequestInit {
  final String method;
  final Headers? headers;
  final Object? body;
  final String? referrer;
  final interop.ReferrerPolicy? referrerPolicy;
  final interop.RequestMode? mode;
  final interop.RequestCredentials? credentials;
  final interop.RequestCache? cache;
  final interop.RequestRedirect? redirect;
  final String? integrity;
  final bool? keepalive;
  final AbortSignal? signal;
  final interop.RequestDuplex? duplex;
  final interop.RequestPriority? priority;

  RequestInit({
    this.method = 'GET',
    this.headers,
    this.body,
    this.referrer,
    this.referrerPolicy,
    this.mode,
    this.credentials,
    this.cache,
    this.redirect,
    this.integrity,
    this.keepalive,
    this.signal,
    this.duplex,
    this.priority,
  });
}

extension RequestInitExtension on RequestInit {
  interop.RequestInit get delegate => interop.RequestInit(
        method: method,
        headers: headers?.delegate,
        body: body,
        referrer: referrer ?? '',
        referrerPolicy: referrerPolicy ?? interop.ReferrerPolicy.empty,
        mode: mode ?? interop.RequestMode.navigate,
        credentials: credentials ?? interop.RequestCredentials.omit,
        cache: cache ?? interop.RequestCache.valueDefault,
        redirect: redirect ?? interop.RequestRedirect.follow,
        integrity: integrity ?? '',
        keepalive: keepalive ?? false,
        signal: signal?.delegate,
        duplex: duplex ?? interop.RequestDuplex.half,
        priority: priority ?? interop.RequestPriority.auto,
      );
}

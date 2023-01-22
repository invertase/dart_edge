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
  Map<String, Object?> toJson() {
    return {
      'method': method,
      if (headers != null) 'headers': headers!.delegate,
      if (body != null) 'body': body,
      if (referrer != null) 'referrer': referrer,
      if (referrerPolicy != null) 'referrerPolicy': referrerPolicy,
      if (mode != null) 'mode': mode,
      if (credentials != null) 'credentials': credentials,
      if (cache != null) 'cache': cache,
      if (redirect != null) 'redirect': redirect,
      if (integrity != null) 'integrity': integrity,
      if (keepalive != null) 'keepalive': keepalive,
      if (signal != null) 'signal': signal!.delegate,
      if (duplex != null) 'duplex': duplex,
      if (priority != null) 'priority': priority,
    };
  }
}

import 'package:js_bindings/js_bindings.dart' as interop;
import 'package:v8_runtime/interop/utils_interop.dart';

import 'abort.dart';
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
  });
}

extension RequestInitExtension on RequestInit {
  Map<String, Object?> toJson() {
    return {
      'method': method,
      'body': body,
      if (headers != null) 'headers': headers!.delegate,
      if (referrer != null) 'referrer': referrer,
      if (referrerPolicy != null) 'referrerPolicy': referrerPolicy!.value,
      if (mode != null) 'mode': mode!.value,
      if (credentials != null) 'credentials': credentials!.value,
      if (cache != null) 'cache': cache!.value,
      if (redirect != null) 'redirect': redirect!.value,
      if (integrity != null) 'integrity': integrity,
      if (keepalive != null) 'keepalive': keepalive,
      if (signal != null) 'signal': signal!.delegate,
      if (duplex != null) 'duplex': duplex!.value,
    };
  }

  // TODO: Using the delegate directly is currently broken due to `null` values
  // not being valid in JS land. Use toJson until this is fixed.
  interop.RequestInit get delegate {
    return interop.RequestInit(
      method: method,
      // Can't pass null here, has to be undefined.
      headers: headers?.delegate ?? jsUndefined,
      body: body,
      referrer: referrer,
      referrerPolicy: referrerPolicy,
      mode: mode,
      credentials: credentials,
      cache: cache,
      redirect: redirect,
      integrity: integrity,
      keepalive: keepalive,
      signal: signal?.delegate,
      duplex: duplex,
    );
  }
}

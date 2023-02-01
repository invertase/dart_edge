import 'dart:js_util';

import 'package:edge/runtime.dart' hide fetch;
import 'package:edge/runtime/headers.dart';
import 'package:edge/runtime/response.dart';
import 'package:edge/runtime/abort.dart';

import 'package:js_bindings/js_bindings.dart' as interop;
import 'package:edge/runtime/interop/utils_interop.dart' as interop;
import 'package:edge/runtime/interop/scope_interop.dart' as interop;

import 'request_init.dart';

Future<Response> fetch(
  Resource resource, {
  CloudflareRequestInit? cf,
  String? method,
  Headers? headers,
  Object? body,
  String? referrer,
  interop.ReferrerPolicy? referrerPolicy,
  interop.RequestMode? mode,
  interop.RequestCredentials? credentials,
  interop.RequestCache? cache,
  interop.RequestRedirect? redirect,
  String? integrity,
  bool? keepalive,
  AbortSignal? signal,
  interop.RequestDuplex? duplex,
}) async {
  return responseFromJsObject(await promiseToFuture(interop.fetch(
    interop.requestFromResource(resource),
    jsify({
      // Cloudflare specific properties
      cf: cf ?? interop.jsUndefined,
      // Fetch API properties
      method: method,
      headers: headers?.delegate,
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
    }),
  )));
}

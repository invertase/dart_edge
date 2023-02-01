import 'dart:async';

import 'package:edge/runtime/abort.dart';
import 'package:edge/runtime/headers.dart';
import 'package:js_bindings/js_bindings.dart' as interop;

import 'package:edge/runtime/request.dart';
import 'package:edge/runtime/response.dart';
import '../interop/durable_object_interop.dart' as interop;

import 'socket.dart';

abstract class Fetcher {
  final interop.Fetcher _delegate;

  Fetcher(this._delegate);

  Future<Response> fetch(
    Request request, {
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
    final response = await _delegate.fetch(
      request.delegate,
      interop.RequestInit(
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
      ),
    );
    return responseFromJsObject(response);
  }

  Socket connect(String address, [SocketOptions? options]) =>
      socketFromJsObject(_delegate.connect(address, options?.delegate));
}

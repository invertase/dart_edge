import 'dart:async';
import 'dart:js';

import 'package:edge/runtime.dart';

StreamController<dynamic> _fetchEvents = StreamController.broadcast();

Stream<dynamic> get fetchEvents async* {
  num count = 0;
  while (context['dartSw'] != 'ready') {
    print(context['dartSw']);
    count++;
    await Future.delayed(Duration(milliseconds: 100));

    if (count > 100) {
      throw Exception('Timeout waiting for service worker registration.');
    }
  }

  yield* _fetchEvents.stream;
}

Request serverRequest(
  String path, {
  String? method,
  Headers? headers,
  Object? body,
  String? referrer,
  ReferrerPolicy? referrerPolicy,
  RequestMode? mode,
  RequestCredentials? credentials,
  RequestCache? cache,
  RequestRedirect? redirect,
  String? integrity,
  bool? keepalive,
  AbortSignal? signal,
  RequestDuplex? duplex,
}) {
  return Request(
    Resource('http://0.0.0.0:3001$path'),
    method: method,
    headers: headers,
    body: body,
    referrer: referrer,
    referrerPolicy: referrerPolicy,
    mode: mode,
    credentials: credentials,
    cache: cache,
    redirect: redirect,
    integrity: integrity,
    keepalive: keepalive,
    signal: signal,
    duplex: duplex,
  );
}

Future<Response> fetchFromServer(
  String path, {
  String? method,
  Headers? headers,
  Object? body,
  String? referrer,
  ReferrerPolicy? referrerPolicy,
  RequestMode? mode,
  RequestCredentials? credentials,
  RequestCache? cache,
  RequestRedirect? redirect,
  String? integrity,
  bool? keepalive,
  AbortSignal? signal,
  RequestDuplex? duplex,
}) {
  return fetch(
    Resource('http://0.0.0.0:3001$path'),
    method: method,
    headers: headers,
    body: body,
    referrer: referrer,
    referrerPolicy: referrerPolicy,
    mode: mode,
    credentials: credentials,
    cache: cache,
    redirect: redirect,
    integrity: integrity,
    keepalive: keepalive,
    signal: signal,
    duplex: duplex,
  );
}

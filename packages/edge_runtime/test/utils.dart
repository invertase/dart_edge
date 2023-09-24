import 'package:edge_runtime/edge_runtime.dart';
import 'package:edge_runtime/src/abort.dart'; // TODO this import should not be necessary

Request serverRequest(String path,
    {String? method,
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
    AbortSignal? signal}) {
  return Request(
      Resource('http://0.0.0.0:3001$path'),
      RequestInit(
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
          signal: signal?.delegate));
}

Future<Response> fetchFromServer(String path,
    {String? method,
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
    AbortSignal? signal}) {
  return fetch(Resource('http://0.0.0.0:3001$path'),
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
      signal: signal);
}

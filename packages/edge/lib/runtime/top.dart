import 'dart:js' as js;
import 'dart:js_util';

import 'package:js_bindings/js_bindings.dart' as interop;
import 'abort.dart';
import 'headers.dart';
import 'interop/scope_interop.dart' as interop;
import 'interop/utils_interop.dart' as interop;

import 'fetch_event.dart';
import 'resource.dart';
import 'response.dart';

void addFetchEventListener(Null Function(FetchEvent event) listener) {
  interop.addEventListener(
    'fetch',
    js.allowInterop((interop.ExtendableEvent delegate) {
      // This needs casting, because the type of the event is not known at compile time.
      listener(fetchEventFromJsObject(delegate as interop.FetchEvent));
    }),
  );
}

Future<Response> fetch(
  Resource resource, {
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
  return responseFromJsObject(
    await promiseToFuture(
      interop.fetch(
        interop.requestFromResource(resource),
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
      ),
    ),
  );
}

String atob(String encodedData) => interop.atob(encodedData);

String btoa(String stringToEncode) => interop.btoa(stringToEncode);

int setInterval(void Function() callback, Duration duration) =>
    interop.setInterval(js.allowInterop(callback), duration.inMilliseconds);

void clearInterval(int handle) => interop.clearInterval(handle);

int setTimeout(void Function() callback, Duration duration) =>
    interop.setTimeout(js.allowInterop(callback), duration.inMilliseconds);

void clearTimeout(int handle) => interop.clearTimeout(handle);

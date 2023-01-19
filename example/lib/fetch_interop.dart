import 'dart:js_util' as js_util;
import 'package:js/js.dart' as js;

@js.JS()
class Promise<T> {
  external Promise(
      void Function(void Function(T result) resolve, Function reject) executor);
  external Promise then(void Function(T result) onFulfilled,
      [Function onRejected]);
}

Promise<T> futureToPromise<T>(Future<T> future) {
  return Promise<T>(js.allowInterop((resolve, reject) {
    future.then(resolve, onError: reject);
  }));
}

@js.JS()
external void addEventListener<T>(String type, void Function(T event) callback);

@js.JS()
class Body {
  external bool get bodyUsed;
  external Promise<String> text(); // Promise<String>
  external Promise<Object> json(); // Promise<T>
  external Promise<Object> formData(); // TODO Promise<FormData>
  external Promise<Object> blob(); // Promise<Blob>
  external Promise<Object> arrayBuffer(); // Promise<ArrayBuffer>
  // TODO
  // readonly body: ReadableStream | null;
}

@js.JS()
class Request extends Body {
  // constructor(input: Request | string, init?: RequestInit | Request);
  external factory Request(Object input, [Object init]);
  external String get method;
  external String get url;
  external String get string;
  external Request clone();
  external Headers get headers;
  external Fetcher? get fetcher;
  external AbortSignal get signal;
  // TODO extension
  // external IncomingRequestCfProperties? get cf;
}

@js.JS()
class Response extends Body {
  // declare type BodyInit =
  // | ReadableStream
  // | string
  // | ArrayBuffer
  // | Blob
  // | URLSearchParams
  // | FormData;
  // constructor(bodyInit?: BodyInit | null, maybeInit?: ResponseInit | Response);
  external factory Response([Object? body, Object init]);
  external Request clone();
  external Headers get headers;
  external int get status;
  external String get statusText;
  external bool get ok;
  external bool get redirected;
  external String get url;
  // TODO
  // readonly webSocket: WebSocket | null;
  // readonly cf?: Object;
}

@js.JS()
class Fetcher {
  // TODO
}

// TODO: Extends EventTarget
@js.JS()
class AbortSignal {
  external static AbortSignal abort([Object reason]);
  external static AbortSignal timeout(num delay);
  external bool get aborted;
  external Object get reason;
  external void throwIfAborted();
}

@js.JS()
class Headers {
  external factory Headers([Object init]);
  external String? get(String name);
  // external List<Object> getAll(String name); CF Only?
  external bool has(String name);
  external void set(String name, String value);
  external void append(String name, String value);
  external void delete(String name);
}

@js.JS()
class FetchEvent {
  external String get type;
  external Request get request;
  // respondWith(promise: Response | Promise<Response>): void;
  external void respondWith(Object r);
  external void passThroughOnException();
  external void waitUntil(Promise promise);
}

// TODO fetch supports String or Request - Not sure on whether Dart API 
// should support due to lack of overloading/unions
@js.JS('fetch')
external Promise<Response> fetch(String resource, [Object init]);

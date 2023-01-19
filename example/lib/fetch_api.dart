import 'dart:async';

import 'package:js/js.dart' as js;
import 'package:js/js_util.dart';

import 'fetch_interop.dart' as interop;

void addEventListener(String type, Function listener) {
  interop.addEventListener(
      type, js.allowInterop((interop.FetchEvent event) {}));
}

class FetchEvent {
  final interop.FetchEvent _delegate;
  FetchEvent._(this._delegate);

  String get type => _delegate.type;
  Request get request => Request._(_delegate.request);
  void respondWith(FutureOr<Response> response) async {
    return _delegate.respondWith((await response)._delegate);
  }
}

class Request {
  final interop.Request _delegate;
  Request._(this._delegate);

  // Request(int status) {
  //   _delegate = interop.Request('GET', 'https://example.com');
  // }

  String get method => _delegate.method;
  String get url => _delegate.url;
  String get string => _delegate.string;
  Request clone() => Request._(_delegate.clone());
  // Headers get headers => Headers._(_delegate.headers);
  // Fetcher? get fetcher => _delegate.fetcher;
  // AbortSignal get signal => AbortSignal._(_delegate.signal);
  // TODO extension
  // IncomingRequestCfProperties? get cf => _delegate.cf;
}

Object? _convertBody(Object? body) {
  if (body == null) {
    return null;
  }

  if (body is String) {
    return body;
  }

  // TODO handle buffers/lisst etc
  throw UnimplementedError('TODO handle me');
}

class Response extends Body {
  Response._(interop.Response delegate) : super._(delegate);

  Response(
    Object? body, {
    int? status,
    String? statusText,
    Headers? headers,
  }) : super._(interop.Response(
            _convertBody(body),
            jsify({
              'status': status,
              'statusText': statusText,
              'headers': headers?._delegate,
            })));

  int get status => _delegate.status;
  String get statusText => _delegate.statusText;
  Headers get headers => Headers._(_delegate.headers);
}

class Body {
  final interop.Response _delegate;

  Body._(this._delegate);

  bool get bodyUsed => _delegate.bodyUsed;
  Future<String> text() => promiseToFuture(_delegate.text());
  Future<Object> json() => promiseToFuture(_delegate.json());
  Future<Object> formData() => promiseToFuture(_delegate.formData());
  Future<Object> blob() => promiseToFuture(_delegate.blob());
  Future<Object> arrayBuffer() => promiseToFuture(_delegate.arrayBuffer());
}

class Headers {
  final interop.Headers _delegate;

  Headers([Map<String, String>? headers])
      : _delegate = interop.Headers(jsify(headers ?? {}));

  Headers._(this._delegate);

  String? get(String name) => _delegate.get(name);
  bool has(String name) => _delegate.has(name);
  void set(String name, String value) => _delegate.set(name, value);
  void append(String name, String value) => _delegate.append(name, value);
  void delete(String name) => _delegate.delete(name);
}

import 'dart:async';

import 'package:js/js.dart' as js;
import 'package:js/js_util.dart';

import 'fetch_interop.dart' as interop;
import 'fetch_cache_interop.dart' as interop_caches;

void addFetchEventListener(Null Function(FetchEvent event) listener) {
  interop.addEventListener<interop.FetchEvent>('fetch',
      js.allowInterop((interop.FetchEvent delegate) {
    listener(FetchEvent._(delegate));
  }));
}

class FetchEvent {
  final interop.FetchEvent _delegate;
  FetchEvent._(this._delegate);

  String get type => _delegate.type;
  Request get request => Request._(_delegate.request);
  void respondWith(FutureOr<Response> response) async {
    return _delegate.respondWith(interop.futureToPromise(Future(() async {
      return (await response)._delegate;
    })));
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
              'headers': headers?._delegate ?? jsify({}),
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

Future<Response> fetch(
  Uri uri, {
  String method = 'GET',
  Headers? headers,
  Object? body,
  FetchMode? mode,
  FetchCredentials? credentials,
  FetchCache? cache,
  FetchRedirect? redirect,
  String? referrer,
  FetchReferrerPolicy? referrerPolicy,
  String? integrity,
  bool? keepalive,
  // AbortSignal? signal, TODO needs to be implemented
}) async {
  return Response._(await promiseToFuture(interop.fetch(
      uri.toString(),
      jsify({
        'method': method,
        if (headers != null) 'headers': headers._delegate,
        if (body != null) 'body': _convertBody(body),
        if (mode != null) 'mode': mode._delegate,
        if (credentials != null) 'credentials': credentials._delegate,
        if (cache != null) 'cache': cache._delegate,
        if (redirect != null) 'redirect': redirect._delegate,
        if (referrer != null) 'referrer': referrer,
        if (referrerPolicy != null) 'referrerPolicy': referrerPolicy._delegate,
        if (integrity != null) 'integrity': integrity,
        if (keepalive != null) 'keepalive': keepalive,
        // if (signal != null) 'signal': signal._delegate,
      }))));
}

enum FetchMode {
  cors('cors'),
  noCors('no-cors'),
  sameOrigin('same-origin');

  const FetchMode(this._delegate);

  final String _delegate;
}

enum FetchCredentials {
  omit('omit'),
  sameOrigin('same-origin'),
  include('include');

  const FetchCredentials(this._delegate);

  final String _delegate;
}

enum FetchCache {
  defaultValue('default'),
  noStore('no-store'),
  reload('reload'),
  noCache('no-cache'),
  forceCache('force-cache'),
  onlyIfCached('only-if-cached');

  const FetchCache(this._delegate);

  final String _delegate;
}

enum FetchRedirect {
  follow('follow'),
  error('error'),
  manual('manual');

  const FetchRedirect(this._delegate);

  final String _delegate;
}

enum FetchReferrerPolicy {
  noReferrer('no-referrer'),
  noReferrerWhenDowngrade('no-referrer-when-downgrade'),
  sameOrigin('same-origin'),
  origin('origin'),
  strictOrigin('strict-origin'),
  originWhenCrossOrigin('origin-when-cross-origin'),
  strictWhenCrossOrigin('strict-origin-when-cross-origin'),
  unsafeUrl('unsafe-url');

  const FetchReferrerPolicy(this._delegate);

  final String _delegate;
}

class CacheStorage {
  const CacheStorage._();

  Cache get defaultCache => Cache._(interop_caches.defaultCache);

  Future<bool> delete(String cacheName) async {
    return promiseToFuture(interop_caches.delete(cacheName));
  }

  Future<bool> has(String cacheName) async {
    return promiseToFuture(interop_caches.has(cacheName));
  }

  Future<List<String>> keys(String cacheName) async {
    final obj =
        await promiseToFuture<List<Object>>(interop_caches.keys(cacheName));
    return dartify(obj) as List<String>;
  }

  Future<Response?> match(Request request) async {
    final obj = await promiseToFuture<interop.Response?>(
        interop_caches.match(request._delegate));
    return obj == null ? null : Response._(obj);
  }

  Future<Cache> open(String name) async {
    return Cache._(await promiseToFuture(interop_caches.open(name)));
  }
}

const caches = CacheStorage._();

class Cache {
  final interop_caches.Cache _delegate;

  Cache._(this._delegate);

  Future<void> add(Uri uri) async {
    await promiseToFuture(_delegate.add(uri.toString()));
  }

  Future<void> addAll(List<Uri> uris) async {
    await promiseToFuture(_delegate
        .addAll(uris.map((uri) => uri.toString()).toList(growable: false)));
  }

  Future<void> delete(
    Uri uri, {
    bool? ignoreSearch,
    bool? ignoreMethod,
    bool? ignoreVary,
    String? cacheName,
  }) async {
    await promiseToFuture(_delegate.delete(uri.toString(), {
      if (ignoreSearch != null) 'ignoreSearch': ignoreSearch,
      if (ignoreMethod != null) 'ignoreMethod': ignoreMethod,
      if (ignoreVary != null) 'ignoreVary': ignoreVary,
      if (cacheName != null) 'cacheName': cacheName,
    }));
  }

  Future<List<Request>> list(
    Uri uri, {
    bool? ignoreSearch,
    bool? ignoreMethod,
    bool? ignoreVary,
    String? cacheName,
  }) async {
    final obj = await promiseToFuture<List<interop.Request>>(
        _delegate.match(uri.toString(), {
      if (ignoreSearch != null) 'ignoreSearch': ignoreSearch,
      if (ignoreMethod != null) 'ignoreMethod': ignoreMethod,
      if (ignoreVary != null) 'ignoreVary': ignoreVary,
      if (cacheName != null) 'cacheName': cacheName,
    }));

    final list = dartify(obj) as List<interop.Request>;
    return list.map((delegate) => Request._(delegate)).toList(growable: false);
  }

  Future<Response?> match(
    Uri uri, {
    bool? ignoreSearch,
    bool? ignoreMethod,
    bool? ignoreVary,
  }) async {
    final obj = await promiseToFuture<interop.Response?>(
        _delegate.match(uri.toString(), {
      if (ignoreSearch != null) 'ignoreSearch': ignoreSearch,
      if (ignoreMethod != null) 'ignoreMethod': ignoreMethod,
      if (ignoreVary != null) 'ignoreVary': ignoreVary,
    }));

    return obj == null ? null : Response._(obj);
  }

  // TODO matchAll
  // TODO put
}

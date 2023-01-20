library fetch_apis;

import 'dart:async';
import 'dart:typed_data';

import 'package:fetch_apis/resource.dart';
import 'dart:js' as js;
import 'dart:js_util' show promiseToFuture, jsify;

import 'package:js_bindings/js_bindings.dart' as interop;
import 'interop/fetch_interop.dart' as interop;

export 'resource.dart' show Resource;

void addFetchEventListener(Null Function(FetchEvent event) listener) {
  if (js.context['window'] == null) {
    js.context['window'] = js.context['self'];
  }
  interop.addEventListener('fetch',
      js.allowInterop((interop.ExtendableEvent delegate) {
    listener(FetchEvent._(delegate as interop.FetchEvent));
  }));
}

interop.Request requestFromResource(Resource resource) {
  return resource.when(
    (url) => interop.Request(url),
    uri: (uri) => interop.Request(uri.toString()),
    request: (request) => request._delegate,
  );
}

class FetchEvent {
  final interop.FetchEvent _delegate;
  FetchEvent._(this._delegate);

  String get type => _delegate.type;
  Request get request => Request._(_delegate.request);

  void respondWith(FutureOr<Response> response) {
    return _delegate.respondWithPromise(Future(() async {
      return (await response)._delegate;
    }));
  }
}

class Request {
  final interop.Request _delegate;
  Request._(this._delegate);

  // Request(int status) {
  //   _delegate = interop.Request('GET', 'https://example.com');
  // }

  Request(
    Resource resource, {
    String? method,
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
    AbortSignal? signal,
  }) : _delegate = interop.Request(
          requestFromResource(resource),
          // TODO use RequestInit class
          jsify({
            if (method != null) 'method': method,
            if (headers != null) 'headers': headers._delegate,
            if (body != null) 'body': _convertBody(body),
            if (mode != null) 'mode': mode._delegate,
            if (credentials != null) 'credentials': credentials._delegate,
            if (cache != null) 'cache': cache._delegate,
            if (redirect != null) 'redirect': redirect._delegate,
            if (referrer != null) 'referrer': referrer,
            if (referrerPolicy != null)
              'referrerPolicy': referrerPolicy._delegate,
            if (integrity != null) 'integrity': integrity,
            if (keepalive != null) 'keepalive': keepalive,
            if (signal != null) 'signal': signal._delegate,
          }),
        );

  String get method => _delegate.method;
  String get url => _delegate.url;

  Request clone() => Request._(_delegate);
  Headers get headers => Headers._(_delegate.headers);
  // Fetcher? get fetcher => _delegate.fetcher;
  AbortSignal get signal => AbortSignal._(_delegate.signal);
  // TODO extension
  // IncomingRequestCfProperties? get cf => _delegate.cf;

  // TODO; more here https://developer.mozilla.org/en-US/docs/Web/API/Request
}

Object? _convertBody(Object? body) {
  if (body == null) {
    return null;
  }

  if (body is String) {
    return body;
  }

  if (body is ByteBuffer) {
    return body;
  }

  throw ArgumentError.value(
    body,
    'body',
    'Body must be an nullable instance of [String] or [Uint8List]',
  );
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

class FormData {
  final interop.FormData _delegate;
  FormData._(this._delegate);

  // TODO
}

class Blob {
  final interop.Blob _delegate;
  Blob._(this._delegate);

  // TODO
}

class Body {
  final interop.Response _delegate;

  Body._(this._delegate);

  bool get bodyUsed => _delegate.bodyUsed;

  Future<String> text() => _delegate.text();
  Future<Object?> json() async =>
      // ignore: unnecessary_cast, Dart issue
      interop.dartify(await (_delegate as interop.Body).json());
  Future<FormData> formData() async => FormData._(await _delegate.formData());
  Future<Object> blob() async => Blob._(await _delegate.blob());
  Future<ByteBuffer> arrayBuffer() async {
    final buffer = await _delegate.arrayBuffer();
    return buffer;
  }
}

class Headers {
  final interop.Headers _delegate;

  Headers([Map<String, String>? headers])
      : _delegate = interop.Headers(jsify(headers ?? {}));

  Headers._(this._delegate);

  String? get(String name) => _delegate.mGet(name);
  bool has(String name) => _delegate.has(name);
  void set(String name, String value) => _delegate.mSet(name, value);
  void append(String name, String value) => _delegate.append(name, value);
  void delete(String name) => _delegate.delete(name);
}

class AbortSignal {
  final interop.AbortSignal _delegate;

  AbortSignal() : _delegate = interop.AbortSignal();

  AbortSignal._(this._delegate);

  static AbortSignal abort([Object? reason]) {
    // TODO check this works calling extension method
    if (reason == null) return AbortSignal._(interop.PropsAbortSignal.abort());
    return AbortSignal._(interop.PropsAbortSignal.abort(jsify(reason)));
  }

  static AbortSignal timeout(int delay) {
    return AbortSignal._(interop.PropsAbortSignal.timeout(delay));
  }

  bool get aborted => _delegate.aborted;
  Object get reason => _delegate.reason;
  void throwIfAborted() => _delegate.throwIfAborted();
}

Future<Response> fetch(
  Resource resource, {
  String? method,
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
  AbortSignal? signal,
}) async {
  final options = jsify({
    if (method != null) 'method': method,
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
    if (signal != null) 'signal': signal._delegate,
  });

  return Response._(
    await promiseToFuture(
        interop.fetch(requestFromResource(resource), options)),
  );
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
  final interop.CacheStorage _delegate;

  CacheStorage._(this._delegate);

  Cache get defaultCache => Cache._(interop.defaultCache);

  Future<bool> delete(String cacheName) async {
    return promiseToFuture(_delegate.delete(cacheName));
  }

  Future<bool> has(String cacheName) async {
    return promiseToFuture(_delegate.has(cacheName));
  }

  Future<Iterable<String>> keys() async {
    return _delegate.keys();
  }

  Future<Response?> match(Request request) async {
    final obj = await promiseToFuture<interop.Response?>(
        _delegate.match(request._delegate));
    return obj == null ? null : Response._(obj);
  }

  Future<Cache> open(String name) async {
    return Cache._(await promiseToFuture(_delegate.open(name)));
  }
}

final caches = CacheStorage._(interop.CacheStorage());

class Cache {
  final interop.Cache _delegate;

  Cache._(this._delegate);

  Future<void> add(Uri uri) async {
    await _delegate.add(uri.toString());
  }

  Future<void> addAll(List<Uri> uris) async {
    await _delegate.addAll(uris.map((uri) => uri.toString()));
  }

  Future<void> delete(
    Uri uri, {
    bool? ignoreSearch,
    bool? ignoreMethod,
    bool? ignoreVary,
  }) async {
    await _delegate.delete(
        uri.toString(),
        interop.CacheQueryOptions(
          ignoreMethod: ignoreMethod,
          ignoreSearch: ignoreSearch,
          ignoreVary: ignoreVary,
        ));
  }

  Future<Response?> match(
    Uri uri, {
    bool? ignoreSearch,
    bool? ignoreMethod,
    bool? ignoreVary,
  }) async {
    final obj = await _delegate.match(
        uri.toString(),
        interop.CacheQueryOptions(
          ignoreMethod: ignoreMethod,
          ignoreSearch: ignoreSearch,
          ignoreVary: ignoreVary,
        ));

    return obj == null ? null : Response._(obj);
  }

  Future<Iterable<Response>> matchAll({
    Uri? uri,
    bool? ignoreSearch,
    bool? ignoreMethod,
    bool? ignoreVary,
  }) async {
    final objs = await _delegate.matchAll(
        uri?.toString(),
        interop.CacheQueryOptions(
          ignoreMethod: ignoreMethod,
          ignoreSearch: ignoreSearch,
          ignoreVary: ignoreVary,
        ));

    return objs.map((obj) => Response._(obj));
  }

  Future<void> put(
    Uri uri,
    Response response,
  ) {
    return _delegate.put(uri.toString(), response._delegate);
  }
}

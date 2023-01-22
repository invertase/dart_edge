library fetch_apis;

import 'dart:async';
import 'dart:typed_data';

import 'package:fetch_apis/resource.dart';
import 'dart:js' as js;
import 'dart:js_util' show promiseToFuture, jsify;

import 'package:js_bindings/js_bindings.dart' as interop;
import 'interop/fetch_interop.dart' as interop;

export 'resource.dart' show Resource;
export 'package:js_bindings/bindings/fetch.dart'
    show
        ResponseType,
        RequestDuplex,
        RequestCache,
        RequestCredentials,
        RequestDestination,
        RequestMode;

void addFetchEventListener(Null Function(FetchEvent event) listener) {
  if (js.context['window'] == null) {
    js.context['window'] = js.context['self'];
  }
  interop.addEventListener(
    'fetch',
    js.allowInterop((interop.ExtendableEvent delegate) {
      listener(FetchEvent._(delegate as interop.FetchEvent));
    }),
  );
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

class Request implements Body {
  final interop.Request _delegate;

  Request._(this._delegate);

  Request(Resource resource, [RequestInit? init])
      : _delegate = interop.Request(
          requestFromResource(resource),
          jsify(init?.toJson() ?? {}),
        );

  String get method => _delegate.method;
  String get url => _delegate.url;
  Headers get headers => Headers._(_delegate.headers);
  // TODO make sure this maps correct as using byName
  interop.RequestDestination get destination => _delegate.destination;
  String get referrer => _delegate.referrer;
  // TODO make sure this maps correct as using byName
  interop.ReferrerPolicy get referrerPolicy => _delegate.referrerPolicy;
  // TODO make sure this maps correct as using byName
  interop.RequestMode get mode => _delegate.mode;
  // TODO make sure this maps correct as using byName
  interop.RequestCredentials get credentials => _delegate.credentials;
  // TODO make sure this maps correct as using byName
  interop.RequestCache get cache => _delegate.cache;
  // TODO make sure this maps correct as using byName
  interop.RequestRedirect get redirect => _delegate.redirect;
  String get integrity => _delegate.integrity;
  bool get keepalive => _delegate.keepalive;
  // Fetcher? get fetcher => _delegate.fetcher;
  AbortSignal get signal => AbortSignal._(_delegate.signal);
  // TODO make sure this maps correct as using byName
  interop.FetchPriority get priority => _delegate.priority;
  Request clone() => Request._(_delegate);

  @override
  Future<ByteBuffer> arrayBuffer() async => _delegate.arrayBuffer();

  @override
  Future<Object> blob() async => Blob._(await _delegate.blob());

  @override
  ReadableStream? get body {
    final body = _delegate.body;
    return body == null ? null : ReadableStream._(body);
  }

  @override
  bool get bodyUsed => _delegate.bodyUsed;

  @override
  Future<FormData> formData() async => FormData._(await _delegate.formData());

  @override
  Future<Object?> json() async =>
      // ignore: unnecessary_cast, Dart issue
      interop.dartify(await (_delegate as interop.Body).json());

  @override
  Future<String> text() async => _delegate.text();

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

  if (body is ByteBuffer) {
    return body;
  }

  throw ArgumentError.value(
    body,
    'body',
    'Body must be an nullable instance of [String] or [Uint8List]',
  );
}

class ResponseInit {
  final int? status;
  final String? statusText;
  final Headers? headers;

  ResponseInit({
    this.status,
    this.statusText,
    this.headers,
  });
}

// Extension since we only need it internally.
extension on ResponseInit {
  Map<String, Object?> toJson() {
    return {
      if (status != null) 'status': status,
      if (statusText != null) 'statusText': statusText,
      if (headers != null) 'headers': headers,
    };
  }
}

class Response implements Body {
  final interop.Response _delegate;

  Response._(this._delegate);

  Response(Object? body, [ResponseInit? init])
      : _delegate = interop.Response(
          _convertBody(body),
          jsify(init?.toJson() ?? {}),
        );

  factory Response.error() {
    return Response._(
      interop.PropsResponse.error(),
    );
  }

  factory Response.redirect(Uri url, [int? status = 302]) {
    return Response._(
      interop.PropsResponse.redirect(url.toString(), status),
    );
  }

  factory Response.json(Object? data, [ResponseInit? init]) {
    return Response._(
      interop.PropsResponse.json(data, jsify(init?.toJson() ?? {})),
    );
  }

  // TODO - I don't think this will work, it uses byName, but
  // valueDefault needs to be mapped to default...
  interop.ResponseType get type => _delegate.type;
  Uri get url => Uri.parse(_delegate.url);
  bool get redirected => _delegate.redirected;
  int get status => _delegate.status;
  bool get ok => _delegate.ok;
  String get statusText => _delegate.statusText;
  Headers get headers => Headers._(_delegate.headers);
  Response clone() => Response._(_delegate.clone());

  @override
  Future<ByteBuffer> arrayBuffer() => _delegate.arrayBuffer();

  @override
  Future<Object> blob() async => Blob._(await _delegate.blob());

  @override
  ReadableStream? get body {
    final body = _delegate.body;
    return body == null ? null : ReadableStream._(body);
  }

  @override
  bool get bodyUsed => _delegate.bodyUsed;

  @override
  Future<FormData> formData() async => FormData._(await _delegate.formData());

  @override
  Future<Object?> json() async =>
      // ignore: unnecessary_cast, Dart issue
      interop.dartify(await (_delegate as interop.Body).json());

  @override
  Future<String> text() => _delegate.text();
}

class FormData {
  final interop.FormData _delegate;
  FormData._(this._delegate);

  FormData() : _delegate = interop.FormData();

  // TODO - FormDataEntryValue - see target
  void append(String name, [Blob? value, String? filename]) {
    _delegate.append(name, value?._delegate, filename);
  }

  void delete(String name) => _delegate.delete(name);
  bool has(String name) => _delegate.has(name);

  // TODO - FormDataEntryValue - see target
  Iterable<dynamic> getAll(String name) => _delegate.getAll(name);

  // TODO - FormDataEntryValue - see target
  operator []=(String name, Object? value) {
    throw UnimplementedError();
    // _delegate.mSet(name, value);
  }

  // TODO - FormDataEntryValue - see target
  dynamic operator [](String name) {
    return _delegate.mGet(name);
  }
}

class Blob {
  final interop.Blob _delegate;
  Blob._(this._delegate);

  // TODO BlobPropertyBag
  Blob([Iterable<dynamic>? blobParts])
      : _delegate = interop.Blob(
          blobParts,
        );

  int get size => _delegate.size;
  String get type => _delegate.type;

  Blob slice([int? start, int? end, String? contentType]) {
    return Blob._(_delegate.slice(start, end, contentType));
  }

  ReadableStream stream() {
    return ReadableStream._(_delegate.stream());
  }

  Future<String> text() => _delegate.text();

  Future<ByteBuffer> arrayBuffer() => _delegate.arrayBuffer();
}

class ReadableStream {
  final interop.ReadableStream _delegate;
  ReadableStream._(this._delegate);

  // TODO
}

// TODO - not sure how to implement the methods from the interop class
abstract class Body {
  // TODO we should have our own ReadableStream
  ReadableStream? get body;
  bool get bodyUsed;
  Future<String> text();
  Future<Object?> json();
  Future<FormData> formData();
  Future<Object> blob();
  Future<ByteBuffer> arrayBuffer();
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

class RequestInit {
  final String method;
  final Headers? headers;
  final Object? body;
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

extension on interop.ReferrerPolicy {
  String get value {
    switch (this) {
      case interop.ReferrerPolicy.empty:
        return 'empty';
      case interop.ReferrerPolicy.noReferrer:
        return 'no-referrer';
      case interop.ReferrerPolicy.noReferrerWhenDowngrade:
        return 'no-referrer-when-downgrade';
      case interop.ReferrerPolicy.sameOrigin:
        return 'same-origin';
      case interop.ReferrerPolicy.origin:
        return 'origin';
      case interop.ReferrerPolicy.strictOrigin:
        return 'strict-origin';
      case interop.ReferrerPolicy.originWhenCrossOrigin:
        return 'origin-when-cross-origin';
      case interop.ReferrerPolicy.strictOriginWhenCrossOrigin:
        return 'strict-origin-when-cross-origin';
      case interop.ReferrerPolicy.unsafeUrl:
        return 'unsafe-url';
    }
  }
}

extension on interop.RequestMode {
  String get value {
    switch (this) {
      case interop.RequestMode.sameOrigin:
        return 'same-origin';
      case interop.RequestMode.noCors:
        return 'no-cors';
      case interop.RequestMode.cors:
        return 'cors';
      case interop.RequestMode.navigate:
        return 'navigate';
    }
  }
}

extension on interop.RequestCredentials {
  String get value {
    switch (this) {
      case interop.RequestCredentials.omit:
        return 'omit';
      case interop.RequestCredentials.sameOrigin:
        return 'same-origin';
      case interop.RequestCredentials.include:
        return 'include';
    }
  }
}

extension on interop.RequestCache {
  String get value {
    switch (this) {
      case interop.RequestCache.valueDefault:
        return 'default';
      case interop.RequestCache.noStore:
        return 'no-store';
      case interop.RequestCache.reload:
        return 'reload';
      case interop.RequestCache.noCache:
        return 'no-cache';
      case interop.RequestCache.forceCache:
        return 'force-cache';
      case interop.RequestCache.onlyIfCached:
        return 'only-if-cached';
    }
  }
}

extension on interop.RequestRedirect {
  String get value {
    switch (this) {
      case interop.RequestRedirect.follow:
        return 'follow';
      case interop.RequestRedirect.error:
        return 'error';
      case interop.RequestRedirect.manual:
        return 'manual';
    }
  }
}

extension on RequestInit {
  Map<String, Object?> toJson() {
    return {
      'method': method,
      if (headers != null) 'headers': headers!._delegate,
      if (body != null) 'body': body,
      if (referrerPolicy != null) 'referrerPolicy': referrerPolicy!.value,
      if (mode != null) 'mode': mode!.value,
      if (credentials != null) 'credentials': credentials!.value,
      if (cache != null) 'cache': cache!.value,
      if (redirect != null) 'redirect': redirect!.value,
      if (integrity != null) 'integrity': integrity,
      if (keepalive != null) 'keepalive': keepalive,
      if (signal != null) 'signal': signal!._delegate,
      if (duplex != null) 'duplex': duplex!.name,
    };
  }
}

Future<Response> fetch(Resource resource, [RequestInit? init]) async {
  return Response._(
    await promiseToFuture(
      interop.fetch(
        requestFromResource(resource),
        jsify(init?.toJson() ?? {}),
      ),
    ),
  );
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

final caches = CacheStorage._(interop.caches);

class Cache {
  final interop.Cache _delegate;

  Cache._(this._delegate);

  Future<void> add(Resource resource) async {
    await _delegate.add(requestFromResource(resource));
  }

  Future<void> addAll(List<Resource> resources) async {
    await _delegate.addAll(resources.map(requestFromResource));
  }

  Future<void> delete(
    Resource resource, {
    bool? ignoreSearch,
    bool? ignoreMethod,
    bool? ignoreVary,
  }) async {
    await _delegate.delete(
      requestFromResource(resource),
      interop.CacheQueryOptions(
        ignoreMethod: ignoreMethod,
        ignoreSearch: ignoreSearch,
        ignoreVary: ignoreVary,
      ),
    );
  }

  Future<Response?> match(
    Resource resource, {
    bool? ignoreSearch,
    bool? ignoreMethod,
    bool? ignoreVary,
  }) async {
    final deleObj = await promiseToFuture(_delegate.match(
        requestFromResource(resource),
        interop.CacheQueryOptions(
          // These need conditional setting (don't set if null) otherwise errors below
          // on CF.
          ignoreMethod: ignoreMethod,
          // Error: The 'ignoreSearch' field on 'CacheQueryOptions' is not implemented.
          // ignoreSearch: ignoreSearch,
          // Error: The 'ignoreVary' field on 'CacheQueryOptions' is not implemented.
          // ignoreVary: ignoreVary,
        )));
    if (deleObj == interop.jsUndefined) {
      return null;
    }
    return deleObj == null ? null : Response._(deleObj);
  }

  Future<Iterable<Response>> matchAll({
    Resource? resource,
    bool? ignoreSearch,
    bool? ignoreMethod,
    bool? ignoreVary,
  }) async {
    final matches = await _delegate.matchAll(
        resource == null ? null : requestFromResource(resource),
        interop.CacheQueryOptions(
          ignoreMethod: ignoreMethod,
          ignoreSearch: ignoreSearch,
          ignoreVary: ignoreVary,
        ));
    return matches.map((obj) => Response._(obj));
  }

  Future<void> put(
    Resource resource,
    Response response,
  ) async {
    // TODO replace with typeguard and don't throw our own
    // error
    // if (response.bodyUsed) {
    //   throw StateError('Response body is already used.');
    // }
    try {
      await _delegate.put(requestFromResource(resource), response._delegate);
    } catch (e, s) {
      print(e);
      print(s);
    }
  }
}

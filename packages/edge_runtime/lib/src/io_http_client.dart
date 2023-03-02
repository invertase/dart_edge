import 'dart:async';
import 'dart:convert';
import 'dart:io' as io;

import 'package:edge_runtime/edge_runtime.dart';

const kUnsupportedEnv = 'Unsupported environment';

class HttpClient implements io.HttpClient {
  @override
  bool autoUncompress = false;
  @override
  Duration? connectionTimeout;

  @override
  Duration idleTimeout = const Duration(seconds: 120);

  @override
  int? maxConnectionsPerHost;

  @override
  String? userAgent;

  Set<HttpClientRequest> _pendingRequests = {};

  @override
  void addCredentials(
    Uri url,
    String realm,
    io.HttpClientCredentials credentials,
  ) {
    // TODO: implement addCredentials
  }

  @override
  void addProxyCredentials(
    String host,
    int port,
    String realm,
    io.HttpClientCredentials credentials,
  ) {
    // TODO: implement addProxyCredentials
  }

  @override
  set authenticate(
    Future<bool> Function(Uri url, String scheme, String? realm)? f,
  ) {
    // TODO: implement authenticate
  }

  @override
  set authenticateProxy(
    Future<bool> Function(
      String host,
      int port,
      String scheme,
      String? realm,
    )?
        f,
  ) {
    // TODO: implement authenticateProxy
  }

  @override
  set badCertificateCallback(
    bool Function(io.X509Certificate cert, String host, int port)? callback,
  ) {
    throw UnsupportedError(kUnsupportedEnv);
  }

  @override
  void close({bool force = false}) {}

  @override
  set connectionFactory(
    Future<io.ConnectionTask<io.Socket>> Function(
      Uri url,
      String? proxyHost,
      int? proxyPort,
    )?
        f,
  ) {
    throw UnsupportedError(kUnsupportedEnv);
  }

  @override
  Future<io.HttpClientRequest> delete(String host, int port, String path) {
    return open('DELETE', host, port, path);
  }

  @override
  Future<io.HttpClientRequest> deleteUrl(Uri url) {
    return openUrl('DELETE', url);
  }

  @override
  set findProxy(String Function(Uri url)? f) {
    throw UnsupportedError(kUnsupportedEnv);
  }

  @override
  Future<io.HttpClientRequest> get(String host, int port, String path) {
    return open('GET', host, port, path);
  }

  @override
  Future<io.HttpClientRequest> getUrl(Uri url) {
    return openUrl('GET', url);
  }

  @override
  Future<io.HttpClientRequest> head(String host, int port, String path) {
    return open('HEAD', host, port, path);
  }

  @override
  Future<io.HttpClientRequest> headUrl(Uri url) {
    return openUrl('HEAD', url);
  }

  @override
  set keyLog(Function(String line)? callback) {
    throw UnsupportedError(kUnsupportedEnv);
  }

  @override
  Future<io.HttpClientRequest> open(
    String method,
    String host,
    int port,
    String path,
  ) async {
    return HttpClientRequest(
      method,
      Resource.uri(
        Uri(
          scheme: 'http',
          host: host,
          port: port,
          path: path,
        ),
      ),
    );
  }

  @override
  Future<io.HttpClientRequest> openUrl(String method, Uri url) {
    return Future.value(HttpClientRequest(method, Resource.uri(url)));
  }

  @override
  Future<io.HttpClientRequest> patch(String host, int port, String path) {
    return open('PATCH', host, port, path);
  }

  @override
  Future<io.HttpClientRequest> patchUrl(Uri url) {
    return openUrl('PATCH', url);
  }

  @override
  Future<io.HttpClientRequest> post(String host, int port, String path) {
    return open('POST', host, port, path);
  }

  @override
  Future<io.HttpClientRequest> postUrl(Uri url) {
    return openUrl('POST', url);
  }

  @override
  Future<io.HttpClientRequest> put(String host, int port, String path) {
    return open('PUT', host, port, path);
  }

  @override
  Future<io.HttpClientRequest> putUrl(Uri url) {
    return openUrl('PUT', url);
  }
}

class HttpClientRequest implements io.HttpClientRequest {
  @override
  bool bufferOutput = true;

  @override
  int contentLength = 0;

  @override
  late Encoding encoding;

  @override
  bool followRedirects = true;

  @override
  int maxRedirects = 5;

  @override
  bool persistentConnection = true;

  final io.HttpHeaders headers;

  final String method;
  late final Uri uri;

  final Resource _resource;
  List<int>? _body;
  final Completer<io.HttpClientResponse> _doneCompleter = Completer();

  AbortController? _abortController;

  HttpClientRequest(this.method, this._resource) : headers = HttpHeaders() {
    uri = Resource.getUri(_resource);
  }

  @override
  void abort([Object? exception, StackTrace? stackTrace]) {
    _abortController?.abort(exception);
  }

  @override
  void add(List<int> data) {
    _body ??= [];
    _body!.addAll(data);
  }

  @override
  void addError(Object error, [StackTrace? stackTrace]) {
    abort(error, stackTrace);
  }

  @override
  Future addStream(Stream<List<int>> stream) {
    final completer = Completer();

    stream.listen(
      add,
      onDone: () => completer.complete(),
      onError: (e, s) => completer.completeError(e, s),
    );

    completer.future.catchError((e, s) {
      _doneCompleter.completeError(e, s);
      throw e;
    });

    return completer.future;
  }

  @override
  Future<io.HttpClientResponse> close() async {
    final fetchResponse = await fetch(
      _resource,
      body: _body,
      headers: Headers((headers as HttpHeaders).toMap()),
      method: method,
      signal: _abortController?.signal,
    );

    final response = HttpClientResponse(fetchResponse);
    _doneCompleter.complete(response);
    return response;
  }

  @override
  io.HttpConnectionInfo? get connectionInfo {
    throw UnsupportedError(kUnsupportedEnv);
  }

  @override
  // TODO: implement cookies
  List<io.Cookie> get cookies => throw UnimplementedError();

  @override
  // TODO: implement done
  Future<io.HttpClientResponse> get done => _doneCompleter.future;

  @override
  Future flush() async {
    return Future.value();
  }

  @override
  void write(Object? object) {
    _body ??= [];
    _body!.addAll(utf8.encode(object.toString()));
  }

  @override
  void writeAll(Iterable objects, [String separator = ""]) {
    write(objects.join(separator));
  }

  @override
  void writeCharCode(int charCode) {
    _body ??= [];
    _body!.add(charCode);
  }

  @override
  void writeln([Object? object = ""]) {
    write(object);
    writeCharCode('\n'.codeUnitAt(0));
  }
}

class HttpHeaders implements io.HttpHeaders {
  HttpHeaders();

  factory HttpHeaders.fromFetchResponseHeaders(Headers headers) {
    final ioHeaders = HttpHeaders();

    // TODO: implement once forEach is available on headers
    // headers.forEach((key, value) {
    //   ioHeaders.set(key, value);
    // });
    return ioHeaders;
  }

  @override
  bool get chunkedTransferEncoding {
    return value(io.HttpHeaders.transferEncodingHeader) == 'chunked';
  }

  set chunkedTransferEncoding(bool value) {
    if (value) {
      set(io.HttpHeaders.transferEncodingHeader, 'chunked');
    } else {
      _headers.remove(io.HttpHeaders.transferEncodingHeader);
    }
  }

  @override
  int get contentLength =>
      int.parse(value(io.HttpHeaders.contentLengthHeader)!);

  set contentLength(int value) {
    set(io.HttpHeaders.contentLengthHeader, value);
  }

  @override
  io.ContentType? get contentType {
    final contentType = value(io.HttpHeaders.contentTypeHeader);
    return contentType != null ? io.ContentType.parse(contentType) : null;
  }

  set contentType(io.ContentType? value) {
    if (value != null) {
      set(io.HttpHeaders.contentTypeHeader, value);
    } else {
      _headers.remove(io.HttpHeaders.contentTypeHeader);
    }
  }

  @override
  DateTime? date;

  @override
  DateTime? expires;

  @override
  String? host;

  @override
  DateTime? ifModifiedSince;

  @override
  bool persistentConnection = true;

  @override
  int? port;

  Map<String, Set<String>> _headers = {};

  @override
  List<String>? operator [](String name) {
    return _headers[name]?.toList();
  }

  @override
  void add(String name, Object value, {bool preserveHeaderCase = false}) {
    final _name = preserveHeaderCase ? name : name.toLowerCase();
    _headers[_name] ??= {};
    _headers[_name]!.add(value.toString());
  }

  @override
  void clear() {
    _headers.clear();
  }

  @override
  void forEach(void Function(String name, List<String> values) action) {
    _headers.forEach((key, value) {
      action(key, value.toList());
    });
  }

  @override
  void noFolding(String name) {
    throw UnsupportedError(kUnsupportedEnv);
  }

  @override
  void remove(String name, Object value) {
    _headers[name]?.remove(value.toString());
  }

  @override
  void removeAll(String name) {
    _headers.remove(name);
  }

  @override
  void set(String name, Object value, {bool preserveHeaderCase = false}) {
    final _name = preserveHeaderCase ? name : name.toLowerCase();
    _headers[_name] = {value.toString()};
  }

  @override
  String? value(String name) {
    if (_headers[name] == null) {
      return null;
    }

    if (_headers[name]!.length > 1) {
      throw StateError('More than one value for header $name');
    }

    return _headers[name]?.first;
  }

  Map<String, String> toMap() {
    final map = <String, String>{};

    _headers.forEach((key, value) {
      map[key] = value.join(',');
    });

    return map;
  }
}

class ValueStreamImpl<T> implements Stream<T> {
  @override
  Future<bool> any(bool Function(T element) test) {
    // TODO: implement any
    throw UnimplementedError();
  }

  @override
  Stream<T> asBroadcastStream(
      {void Function(StreamSubscription<T> subscription)? onListen,
      void Function(StreamSubscription<T> subscription)? onCancel}) {
    // TODO: implement asBroadcastStream
    throw UnimplementedError();
  }

  @override
  Stream<E> asyncExpand<E>(Stream<E>? Function(T event) convert) {
    // TODO: implement asyncExpand
    throw UnimplementedError();
  }

  @override
  Stream<E> asyncMap<E>(FutureOr<E> Function(T event) convert) {
    // TODO: implement asyncMap
    throw UnimplementedError();
  }

  @override
  Stream<R> cast<R>() {
    // TODO: implement cast
    throw UnimplementedError();
  }

  @override
  Future<bool> contains(Object? needle) {
    // TODO: implement contains
    throw UnimplementedError();
  }

  @override
  Stream<T> distinct([bool Function(T previous, T next)? equals]) {
    // TODO: implement distinct
    throw UnimplementedError();
  }

  @override
  Future<E> drain<E>([E? futureValue]) {
    // TODO: implement drain
    throw UnimplementedError();
  }

  @override
  Future<T> elementAt(int index) {
    // TODO: implement elementAt
    throw UnimplementedError();
  }

  @override
  Future<bool> every(bool Function(T element) test) {
    // TODO: implement every
    throw UnimplementedError();
  }

  @override
  Stream<S> expand<S>(Iterable<S> Function(T element) convert) {
    // TODO: implement expand
    throw UnimplementedError();
  }

  @override
  // TODO: implement first
  Future<T> get first => throw UnimplementedError();

  @override
  Future<T> firstWhere(bool Function(T element) test, {T Function()? orElse}) {
    // TODO: implement firstWhere
    throw UnimplementedError();
  }

  @override
  Future<S> fold<S>(S initialValue, S Function(S previous, T element) combine) {
    // TODO: implement fold
    throw UnimplementedError();
  }

  @override
  Future forEach(void Function(T element) action) {
    // TODO: implement forEach
    throw UnimplementedError();
  }

  @override
  Stream<T> handleError(Function onError,
      {bool Function(dynamic error)? test}) {
    // TODO: implement handleError
    throw UnimplementedError();
  }

  @override
  // TODO: implement isBroadcast
  bool get isBroadcast => throw UnimplementedError();

  @override
  // TODO: implement isEmpty
  Future<bool> get isEmpty => throw UnimplementedError();

  @override
  Future<String> join([String separator = ""]) {
    // TODO: implement join
    throw UnimplementedError();
  }

  @override
  // TODO: implement last
  Future<T> get last => throw UnimplementedError();

  @override
  Future<T> lastWhere(bool Function(T element) test, {T Function()? orElse}) {
    // TODO: implement lastWhere
    throw UnimplementedError();
  }

  @override
  // TODO: implement length
  Future<int> get length => throw UnimplementedError();

  @override
  StreamSubscription<T> listen(void Function(T event)? onData,
      {Function? onError, void Function()? onDone, bool? cancelOnError}) {
    // TODO: implement listen
    throw UnimplementedError();
  }

  @override
  Stream<S> map<S>(S Function(T event) convert) {
    // TODO: implement map
    throw UnimplementedError();
  }

  @override
  Future pipe(StreamConsumer<T> streamConsumer) {
    // TODO: implement pipe
    throw UnimplementedError();
  }

  @override
  Future<T> reduce(T Function(T previous, T element) combine) {
    // TODO: implement reduce
    throw UnimplementedError();
  }

  @override
  // TODO: implement single
  Future<T> get single => throw UnimplementedError();

  @override
  Future<T> singleWhere(bool Function(T element) test, {T Function()? orElse}) {
    // TODO: implement singleWhere
    throw UnimplementedError();
  }

  @override
  Stream<T> skip(int count) {
    // TODO: implement skip
    throw UnimplementedError();
  }

  @override
  Stream<T> skipWhile(bool Function(T element) test) {
    // TODO: implement skipWhile
    throw UnimplementedError();
  }

  @override
  Stream<T> take(int count) {
    // TODO: implement take
    throw UnimplementedError();
  }

  @override
  Stream<T> takeWhile(bool Function(T element) test) {
    // TODO: implement takeWhile
    throw UnimplementedError();
  }

  @override
  Stream<T> timeout(Duration timeLimit,
      {void Function(EventSink<T> sink)? onTimeout}) {
    // TODO: implement timeout
    throw UnimplementedError();
  }

  @override
  Future<List<T>> toList() {
    // TODO: implement toList
    throw UnimplementedError();
  }

  @override
  Future<Set<T>> toSet() {
    // TODO: implement toSet
    throw UnimplementedError();
  }

  @override
  Stream<S> transform<S>(StreamTransformer<T, S> streamTransformer) {
    // TODO: implement transform
    throw UnimplementedError();
  }

  @override
  Stream<T> where(bool Function(T event) test) {
    // TODO: implement where
    throw UnimplementedError();
  }
}

class HttpClientResponse extends ValueStreamImpl<List<int>>
    implements io.HttpClientResponse {
  final Response _response;
  late final int contentLength;
  late final io.HttpHeaders headers;

  HttpClientResponse(this._response) {
    headers = HttpHeaders.fromFetchResponseHeaders(_response.headers);
    final contentLengthHeader =
        headers.value(io.HttpHeaders.contentLengthHeader);
    contentLength = int.parse(contentLengthHeader ?? '-1');
  }

  @override
  io.X509Certificate? get certificate =>
      throw UnsupportedError(kUnsupportedEnv);

  @override
  io.HttpClientResponseCompressionState get compressionState {
    throw UnsupportedError(kUnsupportedEnv);
  }

  @override
  io.HttpConnectionInfo? get connectionInfo {
    throw UnsupportedError(kUnsupportedEnv);
  }

  @override
  // TODO: implement cookies
  List<io.Cookie> get cookies => throw UnimplementedError();

  @override
  Future<io.Socket> detachSocket() {
    throw UnsupportedError(kUnsupportedEnv);
  }

  @override
  bool get isRedirect => _response.redirected;

  @override
  bool get persistentConnection {
    return _response.headers.get('connection') == 'keep-alive';
  }

  @override
  String get reasonPhrase => _response.statusText;

  @override
  Future<io.HttpClientResponse> redirect([
    String? method,
    Uri? url,
    bool? followLoops,
  ]) {
    // TODO: implement redirect
    throw UnimplementedError();
  }

  @override
  // TODO: implement redirects
  List<io.RedirectInfo> get redirects => throw UnimplementedError();

  @override
  int get statusCode => _response.status;
}

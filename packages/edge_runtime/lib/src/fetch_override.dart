import 'dart:convert';
import 'dart:io';

import 'top.dart' show fetch;
import 'resource.dart';

class FetchHttpOverride extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    print('CREATE CLIENT');
    return FetchHttpClient(super.createHttpClient(context));
  }
}

class FetchHttpClient implements HttpClient {
  final HttpClient _client;

  FetchHttpClient(this._client)
      : idleTimeout = _client.idleTimeout,
        autoUncompress = _client.autoUncompress,
        connectionTimeout = _client.connectionTimeout,
        userAgent = _client.userAgent,
        maxConnectionsPerHost = _client.maxConnectionsPerHost;

  @override
  bool autoUncompress;

  @override
  Duration? connectionTimeout;

  @override
  Duration idleTimeout;

  @override
  int? maxConnectionsPerHost;

  @override
  String? userAgent;

  @override
  Future<HttpClientRequest> open(
      String method, String host, int port, String path) async {
    final resouce = Resource.uri(Uri(
      host: host,
      port: port,
      path: path,
    ));

    throw UnimplementedError('todo!');
  }

  @override
  Future<HttpClientRequest> openUrl(String method, Uri url) {
    final resource = Resource.uri(url);

    throw UnimplementedError('todo!');
  }

  @override
  Future<HttpClientRequest> delete(String host, int port, String path) {
    return open('delete', host, port, path);
  }

  @override
  Future<HttpClientRequest> deleteUrl(Uri url) {
    return openUrl('delete', url);
  }

  @override
  Future<HttpClientRequest> get(String host, int port, String path) {
    return open('get', host, port, path);
  }

  @override
  Future<HttpClientRequest> getUrl(Uri url) {
    return openUrl('get', url);
  }

  @override
  Future<HttpClientRequest> head(String host, int port, String path) {
    return open('head', host, port, path);
  }

  @override
  Future<HttpClientRequest> headUrl(Uri url) {
    return openUrl('head', url);
  }

  @override
  Future<HttpClientRequest> patch(String host, int port, String path) {
    return open('patch', host, port, path);
  }

  @override
  Future<HttpClientRequest> patchUrl(Uri url) {
    return openUrl('patch', url);
  }

  @override
  Future<HttpClientRequest> post(String host, int port, String path) {
    return open('post', host, port, path);
  }

  @override
  Future<HttpClientRequest> postUrl(Uri url) {
    return openUrl('post', url);
  }

  @override
  Future<HttpClientRequest> put(String host, int port, String path) {
    return open('put', host, port, path);
  }

  @override
  Future<HttpClientRequest> putUrl(Uri url) {
    return openUrl('put', url);
  }

  @override
  void addCredentials(
      Uri url, String realm, HttpClientCredentials credentials) {
    _client.addCredentials(url, realm, credentials);
  }

  @override
  void addProxyCredentials(
      String host, int port, String realm, HttpClientCredentials credentials) {
    _client.addProxyCredentials(host, port, realm, credentials);
  }

  @override
  set authenticate(
      Future<bool> Function(Uri url, String scheme, String? realm)? f) {
    _client.authenticate = f;
  }

  @override
  set authenticateProxy(
      Future<bool> Function(
              String host, int port, String scheme, String? realm)?
          f) {
    _client.authenticateProxy = f;
  }

  @override
  set badCertificateCallback(
      bool Function(X509Certificate cert, String host, int port)? callback) {
    _client.badCertificateCallback = callback;
  }

  @override
  void close({bool force = false}) {
    _client.close(force: force);
  }

  @override
  set connectionFactory(
      Future<ConnectionTask<Socket>> Function(
              Uri url, String? proxyHost, int? proxyPort)?
          f) {
    _client.connectionFactory = f;
  }

  @override
  set findProxy(String Function(Uri url)? f) {
    _client.findProxy = f;
  }

  @override
  set keyLog(Function(String line)? callback) {
    _client.keyLog = callback;
  }
}

class FetchHttpClientRequest implements HttpClientRequest {
  final HttpClientRequest _request;

  FetchHttpClientRequest(this._request)
      : contentLength = _request.contentLength,
        bufferOutput = _request.bufferOutput,
        encoding = _request.encoding,
        followRedirects = _request.followRedirects,
        maxRedirects = _request.maxRedirects,
        persistentConnection = _request.persistentConnection;

  @override
  bool bufferOutput;

  @override
  int contentLength;

  @override
  Encoding encoding;

  @override
  bool followRedirects;

  @override
  int maxRedirects;

  @override
  bool persistentConnection;

  @override
  void abort([Object? exception, StackTrace? stackTrace]) {
    _request.abort(exception, stackTrace);
  }

  @override
  void add(List<int> data) {
    _request.add(data);
  }

  @override
  void addError(Object error, [StackTrace? stackTrace]) {
    _request.addError(error, stackTrace);
  }

  @override
  Future addStream(Stream<List<int>> stream) {
    return _request.addStream(stream);
  }

  @override
  Future<HttpClientResponse> close() {
    return _request.close();
  }

  @override
  HttpConnectionInfo? get connectionInfo => _request.connectionInfo;

  @override
  List<Cookie> get cookies => _request.cookies;

  @override
  Future<HttpClientResponse> get done => _request.done;

  @override
  Future flush() {
    return _request.flush();
  }

  @override
  HttpHeaders get headers => _request.headers;

  @override
  String get method => _request.method;

  @override
  Uri get uri => _request.uri;

  @override
  void write(Object? object) {
    _request.write(object);
  }

  @override
  void writeAll(Iterable objects, [String separator = ""]) {
    _request.writeAll(objects, separator);
  }

  @override
  void writeCharCode(int charCode) {
    _request.writeCharCode(charCode);
  }

  @override
  void writeln([Object? object = ""]) {
    _request.writeln(object);
  }
}

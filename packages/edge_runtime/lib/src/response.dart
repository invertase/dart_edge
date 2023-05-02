import 'dart:convert';
import 'dart:js_util' show jsify, getProperty;
import 'dart:typed_data';

import 'package:js_bindings/js_bindings.dart' as interop;

import './utils.dart';
import 'blob.dart';
import 'body.dart';
import 'form_data.dart';
import 'headers.dart';
import 'interop/headers.dart' as headers_interop;
import 'interop/readable_stream.dart';
import 'interop/utils_interop.dart';

class Response implements Body {
  final interop.Response _delegate;

  Response._(this._delegate);

  /// Creates a new [Response] object.
  /// The [body] can be a [String], [ByteBuffer] or [Uint8List].
  Response(
    Object? body, {
    int status = 200,
    String statusText = '',
    Headers? headers,
  }) : _delegate = interop.Response(
          convertBody(body),
          interop.ResponseInit(
            status: status,
            statusText: statusText,
            headers: headers?.delegate ?? jsUndefined,
          ),
        );

  /// Creates a new [Response] object with an error.
  ///
  /// See also https://developer.mozilla.org/en-US/docs/Web/API/Response/error.
  factory Response.error() {
    return Response._(interop.Response.error());
  }

  /// Creates a new [Response] object with a redirect to the given [url].
  ///
  /// See also https://developer.mozilla.org/en-US/docs/Web/API/Response/redirect.
  factory Response.redirect(Uri url, [int? status = 302]) {
    return Response._(
      interop.Response.redirect(url.toString(), status),
    );
  }

  /// **Warning:** It is recommended to use [Response.json] instead
  /// as this method is less efficient and the response data can become minified
  /// if you enable minification in your build.
  ///
  /// Creates a new [Response] object with a JS object as the body.
  /// Recursively converts a JSON-like collection to JavaScript compatible representation.
  /// The data must be a [Map] or [Iterable], the contents of which are also deeply converted.
  /// Maps are converted into JavaScript objects. Iterables are converted into arrays.
  /// Strings, numbers, bools, and @JS() annotated objects are passed through unmodified.
  /// Dart objects are also passed through unmodified, but their members aren't usable from JavaScript.
  ///
  /// *Copied from [jsify]*.
  factory Response.jsify(
    Object? data, {
    int status = 200,
    String statusText = '',
    Headers? headers,
  }) {
    return Response._(
      interop.Response.json(
        data != null ? jsify(data) : null,
        interop.ResponseInit(
          status: status,
          statusText: statusText,
          headers: headers?.delegate ?? jsUndefined,
        ),
      ),
    );
  }

  /// Creates a new [Response] object with a JSON string as the body.
  /// [data] is converted to a JSON string using [jsonEncode].
  ///
  /// If you are using a JS object as the body, use [Response.jsify] instead.
  factory Response.json(
    Object? data, {
    int status = 200,
    String statusText = '',
    Headers? headers,
  }) {
    return Response._(
      interop.Response(
        data != null ? jsonEncode(data) : null,
        interop.ResponseInit(
          status: status,
          statusText: statusText,
          headers: headers?.delegate ??
              Headers({
                'Content-Type': 'application/json; charset=utf-8',
              }),
        ),
      ),
    );
  }

  interop.ResponseType get type => _delegate.type;
  Uri get url => Uri.parse(_delegate.url);
  bool get redirected => _delegate.redirected;
  int get status => _delegate.status;
  bool get ok => _delegate.ok;
  String get statusText => _delegate.statusText;
  Headers get headers {
    return headersFromJsObject(
      getProperty<headers_interop.Headers>(_delegate, 'headers'),
    );
  }

  Response clone() => Response._(_delegate.clone());

  @override
  Future<ByteBuffer> arrayBuffer() => _delegate.arrayBuffer();

  @override
  Future<Object> blob() async => blobFromJsObject(await _delegate.blob());

  Stream<List<int>>? get body {
    final body = getProperty<ReadableStream?>(_delegate, 'body');
    return body == null ? null : streamFromJSReadable(body);
  }

  @override
  bool get bodyUsed => _delegate.bodyUsed;

  @override
  Future<FormData> formData() async =>
      formDataFromJsObject(await _delegate.formData());

  @override
  Future<Object?> json() async {
    // We don't call `_delegate.json()` directly, as it decodes the JSON
    // from JS `JSON.parse`, which does not translate all values back to Dart
    // correctly (e.g. a List is not translated to a JsArray).
    final text = await _delegate.text();
    return jsonDecode(text);
  }

  @override
  Future<String> text() => _delegate.text();
}

extension ResponseExtension on Response {
  interop.Response get delegate => _delegate;
}

Response responseFromJsObject(interop.Response delegate) {
  return Response._(delegate);
}

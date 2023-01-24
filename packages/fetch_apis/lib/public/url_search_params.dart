import 'package:js/js_util.dart';
import 'package:js_bindings/js_bindings.dart' as interop;

// TODO: Not sure if we actually need this. Uri.queryParameters/All returns
// the same thing as this class which users are comfortable with. If any API
// requires this as an arg, we can shim it in the interop layer.

class URLSearchParams {
  final interop.URLSearchParams _delegate;

  URLSearchParams._(this._delegate);

  URLSearchParams([Map<String, String>? init])
      : _delegate = interop.URLSearchParams(jsify(init ?? {}));

  URLSearchParams.fromUri(Uri uri)
      : _delegate = interop.URLSearchParams(uri.query);

  void append(String name, String value) => _delegate.append(name, value);

  void delete(String name) => _delegate.delete(name);

  Iterable<String> getAll(String name) => _delegate.getAll(name);

  bool has(String name) => _delegate.has(name);

  void sort() => _delegate.sort();

  // TODO: interop missing for entries, keys, values, forEach

  operator []=(String name, String value) {
    _delegate.mSet(name, value);
  }

  String? operator [](String name) {
    return _delegate.mGet(name);
  }

  @override
  String toString() => _delegate.toString();
}

extension URLSearchParamsExtension on URLSearchParams {
  // Returns the underlying JS object.
  interop.URLSearchParams get delegate => _delegate;
}

// Creates a [URLSearchParams] instance from a JS object.
URLSearchParams urlSearchParamsFromJsObject(interop.URLSearchParams delegate) {
  return URLSearchParams._(delegate);
}

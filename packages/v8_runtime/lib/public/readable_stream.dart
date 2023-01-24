import 'package:js_bindings/js_bindings.dart' as interop;

class ReadableStream {
  final interop.ReadableStream _delegate;
  ReadableStream._(this._delegate);

  // TODO
}

ReadableStream readableStreamFromJsObject(interop.ReadableStream delegate) {
  return ReadableStream._(delegate);
}

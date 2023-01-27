import 'dart:typed_data';

import 'package:js_bindings/js_bindings.dart' as interop;

import 'readable_stream.dart';

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
    return readableStreamFromJsObject(_delegate.stream());
  }

  Future<String> text() => _delegate.text();

  Future<ByteBuffer> arrayBuffer() => _delegate.arrayBuffer();
}

extension BlobExtension on Blob {
  interop.Blob get delegate => _delegate;
}

Blob blobFromJsObject(interop.Blob delegate) {
  return Blob._(delegate);
}

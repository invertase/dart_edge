import 'dart:typed_data';

import 'package:js_bindings/js_bindings.dart' as interop;

import 'readable_stream.dart';

export 'package:js_bindings/js_bindings.dart' show EndingType;

class Blob {
  final interop.Blob _delegate;

  Blob._(this._delegate);

  Blob([Iterable<dynamic>? blobParts, BlobPropertyBag? options])
      : _delegate = interop.Blob(
          blobParts,
          options?.delegate ?? interop.BlobPropertyBag(),
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

class BlobPropertyBag {
  String? type;
  interop.EndingType? endings;

  BlobPropertyBag({this.type, this.endings});
}

extension on BlobPropertyBag {
  interop.BlobPropertyBag get delegate {
    return interop.BlobPropertyBag(
      type: type,
      endings: endings,
    );
  }
}

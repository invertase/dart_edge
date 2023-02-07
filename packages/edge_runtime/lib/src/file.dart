import 'dart:typed_data';

import 'package:js_bindings/js_bindings.dart' as interop;

import 'blob.dart';
import 'readable_stream.dart';

class File implements Blob {
  final interop.File _delegate;

  File._(this._delegate);

  String get name => _delegate.name;
  int get lastModified => _delegate.lastModified;
  String? get webkitRelativePath {
    try {
      return _delegate.webkitRelativePath;
    } catch (e) {
      // Throws a JS error if the `webkitdirectory` attribute was not set on
      // the input element, but this is accessed.
      // See: https://developer.mozilla.org/en-US/docs/Web/API/File/webkitRelativePath
      return null;
    }
  }

  @override
  Future<ByteBuffer> arrayBuffer() => _delegate.arrayBuffer();

  @override
  int get size => _delegate.size;

  @override
  Blob slice([int? start, int? end, String? contentType]) {
    return blobFromJsObject(_delegate.slice(start, end, contentType));
  }

  @override
  ReadableStream stream() {
    return readableStreamFromJsObject(_delegate.stream());
  }

  @override
  Future<String> text() => _delegate.text();

  @override
  String get type => _delegate.type;
}

extension FileExtension on File {
  interop.File get delegate => _delegate;
}

File fileFromJsObject(interop.File delegate) {
  return File._(delegate);
}

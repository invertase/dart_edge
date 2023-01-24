import 'dart:typed_data';

import 'package:js_bindings/js_bindings.dart' as interop;

import 'blob.dart';
import 'readable_stream.dart';

// TODO: implement or extend?
class File implements Blob {
  final interop.File _delegate;

  File._(this._delegate);

  String get name => _delegate.name;
  int get lastModified => _delegate.lastModified;
  String get webkitRelativePath => _delegate.webkitRelativePath;

  @override
  Future<ByteBuffer> arrayBuffer() {
    throw UnimplementedError();
  }

  @override
  int get size => _delegate.size;

  @override
  Blob slice([int? start, int? end, String? contentType]) {
    throw UnimplementedError();
  }

  @override
  ReadableStream stream() {
    throw UnimplementedError();
  }

  @override
  Future<String> text() {
    throw UnimplementedError();
  }

  @override
  String get type => throw UnimplementedError();
}

extension FileExtension on File {
  interop.File get delegate => _delegate;
}

File fileFromJsObject(interop.File delegate) {
  return File._(delegate);
}

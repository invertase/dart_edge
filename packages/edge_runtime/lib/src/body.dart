import 'dart:typed_data';

import 'form_data.dart';
import 'readable_stream.dart';

abstract class Body {
  ReadableStream? get body;
  bool get bodyUsed;
  Future<String> text();
  Future<Object?> json();
  Future<FormData> formData();
  Future<Object> blob();
  Future<ByteBuffer> arrayBuffer();
}

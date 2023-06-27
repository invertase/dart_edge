import 'dart:typed_data' show ByteBuffer, Uint8List;

Object? convertBody(Object? body) {
  return switch (body) {
    String || Uint8List || ByteBuffer || null => body,
    _ => throw ArgumentError.value(
        body,
        'body',
        'Body must be a nullable instance of [String], [ByteBuffer] or [Uint8List].',
      ),
  };
}

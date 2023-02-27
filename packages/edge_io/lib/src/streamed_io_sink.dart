import 'dart:async';
import 'dart:convert';
import 'dart:io';

class StreamedIOSink implements IOSink {
  final StreamController<List<int>> _controller = StreamController();
  final File _file;

  @override
  Encoding encoding;

  StreamedIOSink(
    this._file, {
    required this.encoding,
  });

  @override
  void add(List<int> data) {
    _controller.add(data);
  }

  @override
  void addError(Object error, [StackTrace? stackTrace]) {
    _controller.addError(error, stackTrace);
  }

  @override
  Future addStream(Stream<List<int>> stream) {
    return _controller.addStream(stream);
  }

  @override
  Future close() {
    throw UnimplementedError('StreamedIOSink.close');
  }

  @override
  Future get done => _controller.done;

  @override
  Future flush() async {
    final bytes = await _controller.stream.toList();
    await _file.writeAsBytes(bytes.expand((e) => e).toList());
  }

  @override
  void write(Object? object) {
    _controller.add(utf8.encode('$object'));
  }

  @override
  void writeAll(Iterable objects, [String separator = ""]) {
    _controller.add(utf8.encode(objects.join(separator)));
  }

  @override
  void writeCharCode(int charCode) {
    _controller.add(utf8.encode(String.fromCharCode(charCode)));
  }

  @override
  void writeln([Object? object = ""]) {
    _controller.add(utf8.encode('$object'));
  }
}

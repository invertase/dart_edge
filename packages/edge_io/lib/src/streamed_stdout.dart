import 'dart:async';
import 'dart:convert';
import 'dart:io';

class StreamedStdout implements Stdout {
  StreamController<List<int>>? _controllerInstance;

  StreamController<List<int>> get _controller =>
      _controllerInstance ??= StreamController.broadcast();

  @override
  Encoding encoding = utf8;

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
    return _controller.close();
  }

  @override
  Future get done => _controller.done;

  @override
  Future flush() {
    return Future.value();
  }

  @override
  bool get hasTerminal => false;

  @override
  IOSink get nonBlocking =>
      throw UnimplementedError('StreamedStdout.nonBlocking');

  @override
  bool get supportsAnsiEscapes => false;

  @override
  int get terminalColumns => 60;

  @override
  int get terminalLines => 20;

  @override
  void write(Object? object) {
    _controller.add(utf8.encode(object.toString()));
  }

  @override
  void writeAll(Iterable objects, [String sep = ""]) {
    _controller.add(utf8.encode(objects.join(sep)));
  }

  @override
  void writeCharCode(int charCode) {
    _controller.add(utf8.encode(String.fromCharCode(charCode)));
  }

  @override
  void writeln([Object? object = ""]) {
    _controller.add(utf8.encode('$object\n'));
  }
}

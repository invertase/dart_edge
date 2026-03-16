import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:file/file.dart' as f;

/// The prototype of [IOOverrides.socketStartConnect]
typedef SocketStartConnect = Future<ConnectionTask<Socket>> Function(
  Object? host,
  int port, {
  Object? sourceAddress,
  int sourcePort,
});

/// The prototype of [IOOverrides.socketConnect]
typedef SocketConnect = Future<Socket> Function(
  Object? host,
  int port, {
  Object? sourceAddress,
  int sourcePort,
  Duration? timeout,
});

/// The prototype of [IOOverrides.serverSocketBind]
typedef ServerSocketBind = Future<ServerSocket> Function(
  Object? address,
  int port, {
  int backlog,
  bool v6Only,
  bool shared,
});

/// An [IOOverrides] that delegates IO operations to a [f.FileSystem].
class FileSystemToIoOverrideAdapter extends IOOverrides {
  /// An [IOOverrides] that delegates IO operations to a [f.FileSystem].
  FileSystemToIoOverrideAdapter({
    this.fs,
    SocketStartConnect? socketStartConnect,
    ServerSocketBind? serverSocketBind,
    SocketConnect? socketConnect,
    Stdout? stdout,
    Stdout? stderr,
  })  : _socketStartConnect = socketStartConnect,
        _socketConnect = socketConnect,
        _stderr = stderr,
        _stdout = stdout,
        _serverSocketBind = serverSocketBind;

  // TODO(rrousselGit): how to mock stdin?

  @override
  Stdout get stderr => _stderr ?? super.stderr;

  @override
  Stdout get stdout => _stdout ?? super.stdout;

  /// The file system to delegate IO operations to.
  final f.FileSystem? fs;

  final Stdout? _stdout;
  final Stdout? _stderr;
  final SocketStartConnect? _socketStartConnect;
  final SocketConnect? _socketConnect;
  final ServerSocketBind? _serverSocketBind;

  @override
  Directory createDirectory(String path) {
    return fs?.directory(path) ?? super.createDirectory(path);
  }

  @override
  File createFile(String path) {
    return fs?.file(path) ?? super.createFile(path);
  }

  @override
  Link createLink(String path) {
    return fs?.link(path) ?? super.createLink(path);
  }

  @override
  Stream<FileSystemEvent> fsWatch(
    String path,
    int events,
    bool recursive,
  ) async* {
    final fs = this.fs;
    if (fs == null) {
      yield* super.fsWatch(path, events, recursive);
      return;
    }

    final type = await fs.type(path);

    f.FileSystemEntity entity;
    switch (type) {
      case f.FileSystemEntityType.directory:
        entity = fs.directory(path);
        break;
      case f.FileSystemEntityType.file:
        entity = fs.file(path);
        break;
      case f.FileSystemEntityType.link:
        entity = fs.link(path);
        break;
      // ignore: no_default_cases, new lints for when patterns land?
      default:
        throw ArgumentError.value(
          path,
          'path',
          'point to an entity of type $type, but expected a directory/file/link.',
        );
    }

    yield* entity.watch(
      events: events,
      recursive: recursive,
    );
  }

  @override
  bool fsWatchIsSupported() =>
      fs?.isWatchSupported ?? super.fsWatchIsSupported();

  @override
  Future<FileSystemEntityType> fseGetType(String path, bool followLinks) async {
    return fs?.type(path, followLinks: followLinks) ??
        super.fseGetType(path, followLinks);
  }

  @override
  FileSystemEntityType fseGetTypeSync(String path, bool followLinks) {
    return fs?.typeSync(path, followLinks: followLinks) ??
        super.fseGetTypeSync(path, followLinks);
  }

  @override
  Future<bool> fseIdentical(String path1, String path2) {
    return fs?.identical(path1, path2) ?? super.fseIdentical(path1, path2);
  }

  @override
  bool fseIdenticalSync(String path1, String path2) {
    return fs?.identicalSync(path1, path2) ??
        super.fseIdenticalSync(path1, path2);
  }

  @override
  Directory getCurrentDirectory() {
    return fs?.currentDirectory ?? super.getCurrentDirectory();
  }

  @override
  void setCurrentDirectory(String path) {
    if (fs == null) {
      super.setCurrentDirectory(path);
      return;
    }

    fs!.currentDirectory = path;
  }

  @override
  Directory getSystemTempDirectory() {
    return fs?.systemTempDirectory ?? super.getSystemTempDirectory();
  }

  @override
  Future<FileStat> stat(String path) => fs?.stat(path) ?? super.stat(path);

  @override
  FileStat statSync(String path) => fs?.statSync(path) ?? super.statSync(path);

  @override
  Future<ConnectionTask<Socket>> socketStartConnect(
    Object? host,
    int port, {
    Object? sourceAddress,
    int sourcePort = 0,
  }) {
    final socketStartConnect = _socketStartConnect;
    if (socketStartConnect != null) {
      return socketStartConnect(
        host,
        port,
        sourceAddress: sourceAddress,
        sourcePort: sourcePort,
      );
    }

    return super.socketStartConnect(
      host,
      port,
      sourceAddress: sourceAddress,
      sourcePort: sourcePort,
    );
  }

  @override
  Future<ServerSocket> serverSocketBind(
    Object? address,
    int port, {
    int backlog = 0,
    bool v6Only = false,
    bool shared = false,
  }) {
    final serverSocketBind = _serverSocketBind;
    if (serverSocketBind != null) {
      return serverSocketBind(
        address,
        port,
        backlog: backlog,
        v6Only: v6Only,
        shared: shared,
      );
    }

    return super.serverSocketBind(
      address,
      port,
      backlog: backlog,
      v6Only: v6Only,
      shared: shared,
    );
  }

  @override
  Future<Socket> socketConnect(
    Object? host,
    int port, {
    Object? sourceAddress,
    int sourcePort = 0,
    Duration? timeout,
  }) {
    final socketConnect = _socketConnect;
    if (socketConnect != null) {
      return socketConnect(
        host,
        port,
        sourceAddress: sourceAddress,
        sourcePort: sourcePort,
        timeout: timeout,
      );
    }

    return super.socketConnect(
      host,
      port,
      sourceAddress: sourceAddress,
      sourcePort: sourcePort,
      timeout: timeout,
    );
  }
}

/// A custom implementation of [Stdout], which can be sent to [IOOverrides].
class CustomStdout implements Stdout {
  /// A custom implementation of [Stdout], which can be sent to [IOOverrides].
  CustomStdout({
    this.encoding = systemEncoding,
    this.hasTerminal = true,
    this.supportsAnsiEscapes = true,
    this.terminalColumns = 80,
    this.terminalLines = 24,
  });

  final _controller = StreamController<List<int>>();

  /// The output stream, post encoding.
  Stream<List<int>> get stream => _controller.stream;

  @override
  Future<void> get done => _controller.done;

  @override
  IOSink get nonBlocking => this;

  @override
  bool hasTerminal;

  @override
  bool supportsAnsiEscapes;

  @override
  int terminalColumns;

  @override
  int terminalLines;

  @override
  Encoding encoding;

  @override
  void add(List<int> data) => _controller.add(data);

  @override
  void addError(Object error, [StackTrace? stackTrace]) {
    _controller.addError(error, stackTrace);
  }

  @override
  Future<void> addStream(Stream<List<int>> stream) {
    return _controller.addStream(stream);
  }

  @override
  Future<void> flush() {
    // TODO(rrousselGit): is there anything to do here?
    return Future.value();
  }

  @override
  void write(Object? object) {
    add(encoding.encode(object.toString()));
  }

  @override
  void writeAll(
    Iterable<Object?> objects, [
    String sep = '',
  ]) {
    write(objects.join(sep));
  }

  @override
  void writeCharCode(int charCode) {
    write(String.fromCharCode(charCode));
  }

  @override
  void writeln([Object? object = '']) {
    write(object);
    write('\n');
  }

  @override
  Future<void> close() {
    return _controller.close();
  }
}

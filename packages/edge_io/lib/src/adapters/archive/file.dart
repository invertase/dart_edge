part of edge_io.archive;

class ArchiveFile extends ReadOnlyFile {
  final MapBasedFileSystem _fs;
  final String _path;

  ArchiveFile._(this._fs, this._path);

  @override
  File get absolute => this;

  @override
  Future<bool> exists() {
    return Future.value(existsSync());
  }

  @override
  bool existsSync() {
    return _fs.get<ArchiveFileImplementation>(_path) != null;
  }

  @override
  bool get isAbsolute => true;

  @override
  Future<DateTime> lastAccessed() {
    return Future.value(lastAccessedSync());
  }

  @override
  DateTime lastAccessedSync() {
    return lastModifiedSync();
  }

  @override
  Future<DateTime> lastModified() {
    return Future.value(lastModifiedSync());
  }

  @override
  DateTime lastModifiedSync() {
    final file = assertIsFile<ArchiveFileImplementation>(_fs, path);
    return DateTime.fromMillisecondsSinceEpoch(file.lastModTime * 1000);
  }

  @override
  Future<int> length() {
    return Future.value(lengthSync());
  }

  @override
  int lengthSync() {
    return readAsBytesSync().length;
  }

  @override
  Future<RandomAccessFile> open({FileMode mode = FileMode.read}) {
    throw UnimplementedError('ArchiveFile.open');
  }

  @override
  Stream<List<int>> openRead([int? start, int? end]) {
    final bytes = readAsBytesSync();
    return Stream.value(bytes.sublist(start ?? 0, end ?? bytes.length));
  }

  @override
  RandomAccessFile openSync({FileMode mode = FileMode.read}) {
    throw UnimplementedError();
  }

  @override
  Directory get parent => ArchiveDirectory._(_fs, p.dirname(path));

  @override
  String get path => _fs.resolve(_path);

  @override
  Future<Uint8List> readAsBytes() {
    return Future.value(readAsBytesSync());
  }

  @override
  Uint8List readAsBytesSync() {
    final file = assertIsFile<ArchiveFileImplementation>(_fs, path);
    return file.content;
  }

  @override
  Future<List<String>> readAsLines({Encoding encoding = utf8}) {
    return Future.value(readAsLinesSync(encoding: encoding));
  }

  @override
  List<String> readAsLinesSync({Encoding encoding = utf8}) {
    return LineSplitter().convert(readAsStringSync(encoding: encoding));
  }

  @override
  Future<String> readAsString({Encoding encoding = utf8}) {
    return Future.value(readAsStringSync(encoding: encoding));
  }

  @override
  String readAsStringSync({Encoding encoding = utf8}) {
    return encoding.decode(readAsBytesSync());
  }

  @override
  String resolveSymbolicLinksSync() {
    final file = assertIsFile<ArchiveFileImplementation>(_fs, path);

    if (file.isSymbolicLink) {
      return file.nameOfLinkedFile;
    }

    return file.name;
  }

  @override
  FileStat statSync() {
    throw UnimplementedError('ArchiveFile.statSync');
  }

  @override
  Uri get uri => Uri.file(path);

  @override
  Stream<FileSystemEvent> watch(
      {int events = FileSystemEvent.all, bool recursive = false}) {
    throw UnimplementedError('ArchiveFile.watch');
  }
}

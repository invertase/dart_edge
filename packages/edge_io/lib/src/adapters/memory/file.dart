part of edge_io.memory;

/// A file in the memory file system.
class MemoryFile extends MemoryFsEntity implements File {
  /// Creates a new file.
  MemoryFile._(super._fs, super.path);

  @override
  Future<File> rename(String newPath) {
    return Future.value(renameSync(newPath));
  }

  @override
  File renameSync(String newPath) {
    final file = assertIsFile(_fs, path, 'Cannot rename file to "$newPath"');

    final newFile = MemoryFile._(_fs, newPath);
    newFile.createSync();

    _fs.remove(path); // Remove the old file.
    _fs.set(newPath, file); // Copy the new file over

    return newFile;
  }

  // TODO should this use Directory.current, which uses basePath?
  @override
  File get absolute => this;

  @override
  bool existsSync() {
    return _fs.get<MemoryFileImplementation>(path) != null;
  }

  @override
  Future<File> copy(String newPath) {
    return Future.value(copySync(newPath));
  }

  @override
  File copySync(String newPath) {
    final file = assertIsFile(_fs, path, 'Cannot rename file to "$newPath"');

    final newFile = MemoryFile._(_fs, newPath);
    newFile.createSync();

    _fs.set(newPath, file); // Copy the new file over

    return newFile;
  }

  @override
  Future<File> create({bool recursive = false, bool exclusive = false}) async {
    createSync(recursive: recursive, exclusive: exclusive);
    return this;
  }

  @override
  void createSync({bool recursive = false, bool exclusive = false}) {
    if (!recursive) assertParentDirectory(_fs, path);
    if (exclusive) assertFileDoesNotExist(_fs, path, 'Cannot create file');

    if (recursive) {
      _fs.setRecursively(path, MemoryFileImplementation());
    } else {
      _fs.set(path, MemoryFileImplementation());
    }
  }

  @override
  Future<DateTime> lastAccessed() {
    return Future.value(lastAccessedSync());
  }

  @override
  DateTime lastAccessedSync() {
    return assertIsFile(_fs, path, 'Cannot retrieve access time').lastAccessed;
  }

  @override
  Future<DateTime> lastModified() {
    return Future.value(lastModifiedSync());
  }

  @override
  DateTime lastModifiedSync() {
    return assertIsFile(_fs, path, 'Cannot retrieve modification time')
        .lastModified;
  }

  @override
  Future<int> length() {
    return Future.value(lengthSync());
  }

  @override
  int lengthSync() {
    assertIsFile(_fs, path, 'Cannot retrieve length of file');
    return readAsBytesSync().length;
  }

  @override
  Future<RandomAccessFile> open({FileMode mode = FileMode.read}) {
    return Future.value(openSync(mode: mode));
  }

  @override
  Stream<List<int>> openRead([int? start, int? end]) {
    Uint8List bytes = readAsBytesSync();

    if (start != null) {
      bytes = end == null
          ? bytes.sublist(start)
          : bytes.sublist(start, math.min(end, bytes.length));
    }

    return Stream.value(bytes.sublist(start ?? 0, end));
  }

  @override
  RandomAccessFile openSync({FileMode mode = FileMode.read}) {
    assertIsFile(_fs, path, 'Cannot open file');
    return MemoryRandomAccessFile(_fs, path, mode: mode);
  }

  @override
  IOSink openWrite({FileMode mode = FileMode.write, Encoding encoding = utf8}) {
    assertIsFile(_fs, path, 'Cannot open file');
    return StreamedIOSink(this, encoding: encoding);
  }

  @override
  Future<Uint8List> readAsBytes() {
    return Future.value(readAsBytesSync());
  }

  @override
  Uint8List readAsBytesSync() {
    final file = assertIsFile(_fs, path, 'Cannot open file');
    return Uint8List.fromList(file.bytes);
  }

  @override
  Future<List<String>> readAsLines({Encoding encoding = utf8}) {
    return Future.value(readAsLinesSync(encoding: encoding));
  }

  @override
  List<String> readAsLinesSync({Encoding encoding = utf8}) {
    final value = readAsStringSync(encoding: encoding);
    return LineSplitter.split(value).toList();
  }

  @override
  Future<String> readAsString({Encoding encoding = utf8}) {
    return Future.value(readAsStringSync(encoding: encoding));
  }

  @override
  String readAsStringSync({Encoding encoding = utf8}) {
    return utf8.decode(readAsBytesSync());
  }

  @override
  Future setLastAccessed(DateTime time) async {
    setLastAccessedSync(time);
  }

  @override
  void setLastAccessedSync(DateTime time) {
    final file = assertIsFile(_fs, path, 'Cannot set access time');
    file.lastAccessed = time;
  }

  @override
  Future setLastModified(DateTime time) async {
    setLastModifiedSync(time);
  }

  @override
  void setLastModifiedSync(DateTime time) {
    final file =
        assertIsFile(_fs, path, 'Failed to set file modification time');
    file.lastModified = time;
  }

  @override
  Future<File> writeAsBytes(List<int> bytes,
      {FileMode mode = FileMode.write, bool flush = false}) {
    writeAsBytesSync(bytes, mode: mode, flush: flush);
    return Future.value(this);
  }

  @override
  void writeAsBytesSync(List<int> bytes,
      {FileMode mode = FileMode.write, bool flush = false}) {
    final existing = _fs.get<MemoryFileImplementation>(path);

    // If nothing exists, attempt create a new file.
    if (existing == null) {
      createSync();
    }

    final file = existing ?? MemoryFileImplementation();

    switch (mode) {
      case FileMode.write:
      case FileMode.writeOnly:
        file.bytes = bytes;
        break;
      case FileMode.append:
      case FileMode.writeOnlyAppend:
        file.bytes.addAll(bytes);
        break;
      case FileMode.read:
        throw FileSystemException(
          'Cannot write to file in read mode',
          path,
          OSError('Invalid argument', 22),
        );
    }

    _fs.set(path, file);
  }

  @override
  Future<File> writeAsString(String contents,
      {FileMode mode = FileMode.write,
      Encoding encoding = utf8,
      bool flush = false}) async {
    writeAsStringSync(contents, mode: mode, encoding: encoding, flush: flush);
    return this;
  }

  @override
  void writeAsStringSync(String contents,
      {FileMode mode = FileMode.write,
      Encoding encoding = utf8,
      bool flush = false}) {
    writeAsBytesSync(utf8.encode(contents), mode: mode, flush: flush);
  }

  @override
  String resolveSymbolicLinksSync() {
    throw UnimplementedError('File.resolveSymbolicLinksSync');
  }

  @override
  FileStat statSync() {
    return MemoryFileStat(_fs, path);
  }

  @override
  Stream<FileSystemEvent> watch(
      {int events = FileSystemEvent.all, bool recursive = false}) {
    throw UnimplementedError('File.watch');
  }
}

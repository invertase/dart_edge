part of edge_io.memory;

/// A file in the memory file system.
class MemoryFile extends MemoryFsEntity implements File {
  /// Creates a new file.
  MemoryFile._(super.overrides, super.path);

  @override
  Future<File> rename(String newPath) {
    return Future.value(renameSync(newPath));
  }

  @override
  File renameSync(String newPath) {
    final existing = overrides._entities.get<MemoryFileImplementation>(path);

    if (existing == null) {
      throw PathNotFoundException(
        path,
        OSError("No such file or directory", 2),
        "Cannot rename file to '$newPath",
      );
    }

    overrides._entities.remove(path); // Remove the old file.
    overrides._entities.set(newPath, existing);

    return MemoryFile._(overrides, newPath);
  }

  // TODO should this use Directory.current, which uses basePath?
  @override
  File get absolute => this;

  @override
  Future<File> copy(String newPath) {
    return Future.value(copySync(newPath));
  }

  @override
  File copySync(String newPath) {
    final existing = overrides._entities.get<MemoryFileImplementation>(path);

    if (existing == null) {
      throw PathNotFoundException(
        path,
        OSError("No such file or directory", 2),
        "Cannot copy file to '$newPath",
      );
    }

    overrides._entities.set(newPath, existing);
    return MemoryFile._(overrides, newPath);
  }

  @override
  Future<File> create({bool recursive = false, bool exclusive = false}) async {
    createSync(recursive: recursive, exclusive: exclusive);
    return this;
  }

  @override
  void createSync({bool recursive = false, bool exclusive = false}) {
    // If recursive is false, we should check whether this file has a parent,
    // and if not, throw an error.
    if (!recursive && _segments.length > 1 && _parentNode == null) {
      throw PathNotFoundException(
        path,
        OSError("No such file or directory", 2),
        "Cannot create file at '$path",
      );
    }

    final existing = overrides._entities.get<MemoryFileImplementation>(path);

    // If the file exists, and we're in exclusive mode, throw an error.
    if (existing != null && exclusive) {
      throw FileSystemException(
        "Cannot create file",
        path,
        OSError("File exists", 17),
      );
    }

    overrides._entities.set(path, MemoryFileImplementation());
  }

  @override
  Future<DateTime> lastAccessed() {
    return Future.value(lastAccessedSync());
  }

  @override
  DateTime lastAccessedSync() {
    final file = overrides._entities.get<MemoryFileImplementation>(path);

    if (file == null) {
      throw PathNotFoundException(
        path,
        OSError("No such file or directory", 2),
        "Cannot retrieve access time",
      );
    }

    return file.lastAccessed;
  }

  @override
  Future<DateTime> lastModified() {
    return Future.value(lastModifiedSync());
  }

  @override
  DateTime lastModifiedSync() {
    final file = overrides._entities.get<MemoryFileImplementation>(path);

    if (file == null) {
      throw PathNotFoundException(
        path,
        OSError("No such file or directory", 2),
        "Cannot retrieve modification time",
      );
    }

    return file.lastModified;
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
    return Future.value(openSync(mode: mode));
  }

  @override
  Stream<List<int>> openRead([int? start, int? end]) {
    final bytes = readAsBytesSync();
    return Stream.value(bytes.sublist(start ?? 0, end));
  }

  @override
  RandomAccessFile openSync({FileMode mode = FileMode.read}) {
    // TODO: implement openSync
    throw UnimplementedError();
  }

  @override
  IOSink openWrite({FileMode mode = FileMode.write, Encoding encoding = utf8}) {
    // TODO: implement openWrite
    throw UnimplementedError();
  }

  @override
  Future<Uint8List> readAsBytes() {
    return Future.value(readAsBytesSync());
  }

  @override
  Uint8List readAsBytesSync() {
    // TODO: This should probably use open()?
    final file = overrides._entities.get<MemoryFileImplementation>(path);

    if (file is MemoryFileImplementation) {
      return Uint8List.fromList(file.bytes);
    }

    throw FileSystemException('File does not exist', path);
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
    final file = overrides._entities.get<MemoryFileImplementation>(path);

    if (file == null) {
      throw FileSystemException(
        'Failed to set file access time',
        path,
        OSError('No such file or directory', 2),
      );
    }

    file.lastAccessed = time;
  }

  @override
  Future setLastModified(DateTime time) async {
    setLastModifiedSync(time);
  }

  @override
  void setLastModifiedSync(DateTime time) {
    final file = overrides._entities.get<MemoryFileImplementation>(path);

    if (file == null) {
      throw FileSystemException(
        'Failed to set file modification time',
        path,
        OSError('No such file or directory', 2),
      );
    }

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
    final existing = overrides._entities.get<MemoryFileImplementation>(path);

    // TODO try open the file - it should error if it can't

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
    }

    overrides._entities.set(path, file);
  }

  @override
  Future<File> writeAsString(String contents,
      {FileMode mode = FileMode.write,
      Encoding encoding = utf8,
      bool flush = false}) {
    writeAsStringSync(contents, mode: mode, encoding: encoding, flush: flush);
    return Future.value(this);
  }

  @override
  void writeAsStringSync(String contents,
      {FileMode mode = FileMode.write,
      Encoding encoding = utf8,
      bool flush = false}) {
    writeAsBytesSync(utf8.encode(contents), mode: mode, flush: flush);
  }
}

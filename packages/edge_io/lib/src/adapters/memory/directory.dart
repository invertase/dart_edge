part of edge_io.memory;

/// An in-memory implementation of [Directory].
class MemoryDirectory extends MemoryFsEntity implements Directory {
  /// Creates a new [MemoryDirectory] instance.
  MemoryDirectory._(super._fs, super.path);

  @override
  bool existsSync() {
    return _fs.get<MapBasedFsDirectoryImplementation>(path) != null;
  }

  @override
  Future<Directory> rename(String newPath) {
    return Future.value(renameSync(newPath));
  }

  @override
  Directory renameSync(String newPath) {
    final dir = assertDirectoryIsEmpty(_fs, path, 'Rename failed');

    final newDir = MemoryDirectory._(_fs, newPath);
    newDir.createSync();

    _fs.remove(path); // Remove the old directory.
    _fs.set(newPath, dir);

    return MemoryDirectory._(_fs, newPath);
  }

  @override
  Directory get absolute => MemoryDirectory._(_fs, _fs.resolve(path));

  @override
  Future<Directory> create({bool recursive = false}) async {
    createSync(recursive: recursive);
    return this;
  }

  @override
  void createSync({bool recursive = false}) {
    if (!recursive) assertParentDirectory(_fs, path);

    if (recursive) {
      _fs.setRecursively(path, MapBasedFsDirectoryImplementation());
    } else {
      _fs.set(path, MapBasedFsDirectoryImplementation());
    }
  }

  @override
  Future<Directory> createTemp([String? prefix]) async {
    return Future.value(createTempSync(prefix));
  }

  @override
  Directory createTempSync([String? prefix]) {
    throw UnimplementedError();
  }

  @override
  Stream<FileSystemEntity> list(
      {bool recursive = false, bool followLinks = true}) {
    return Stream.fromIterable(
        listSync(recursive: recursive, followLinks: followLinks));
  }

  @override
  List<FileSystemEntity> listSync(
      {bool recursive = false, bool followLinks = true}) {
    assertDirectoryIsEmpty(_fs, path, 'Directory listing failed');

    final map = _fs.toMap();
    final entities = <FileSystemEntity>[];

    FileSystemEntity toEntity(MapBasedFsImplementation impl) {
      if (impl is MapBasedFsFileImplementation) {
        return MemoryFile._(_fs, path);
      } else if (impl is MapBasedFsDirectoryImplementation) {
        return MemoryDirectory._(_fs, path);
      } else {
        throw StateError("Unknown entity type");
      }
    }

    // TODO(ehesp): Implement followLinks
    // TODO could move to MapBasedFileSystem as utility method
    if (recursive) {
      for (final entry in map.entries) {
        if (entry.key.startsWith(absolute.path) && entry.key != absolute.path) {
          entities.add(toEntity(entry.value!));
        }
      }
    } else {
      for (final entry in map.entries) {
        if (entry.key.startsWith(absolute.path) &&
            entry.key.split("/").length ==
                absolute.path.split("/").length + 1) {
          entities.add(toEntity(entry.value!));
        }
      }
    }

    return entities;
  }

  @override
  String resolveSymbolicLinksSync() {
    throw UnimplementedError('Directory.resolveSymbolicLinksSync');
  }

  @override
  FileStat statSync() {
    return MemoryFileStat(_fs, path);
  }

  @override
  Stream<FileSystemEvent> watch(
      {int events = FileSystemEvent.all, bool recursive = false}) {
    throw UnimplementedError('Directory.watch');
  }
}

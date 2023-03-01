part of edge_io.archive;

class ArchiveDirectory extends ReadOnlyDirectory implements ArchiveFsEntity {
  final MapBasedFileSystem _fs;
  final String _path;

  ArchiveDirectory._(this._fs, this._path);

  @override
  Directory get absolute => throw UnimplementedError();

  @override
  bool existsSync() {
    return _fs.get<MapBasedFsDirectoryImplementation>(_path) != null;
  }

  @override
  bool get isAbsolute => true;

  @override
  Stream<FileSystemEntity> list(
      {bool recursive = false, bool followLinks = true}) {
    return Stream.fromIterable(listSync(recursive: recursive));
  }

  @override
  List<FileSystemEntity> listSync(
      {bool recursive = false, bool followLinks = true}) {
    assertIsDirectory(_fs, path);

    final map = _fs.toMap();
    final entities = <FileSystemEntity>[];

    FileSystemEntity toEntity(MapBasedFsImplementation impl) {
      if (impl is MapBasedFsFileImplementation) {
        return ArchiveFile._(_fs, path);
      } else if (impl is MapBasedFsDirectoryImplementation) {
        return ArchiveDirectory._(_fs, path);
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
  Directory get parent => ArchiveDirectory._(_fs, p.dirname(_path));

  @override
  String get path => _fs.resolve(_path);

  @override
  String resolveSymbolicLinksSync() {
    assertIsDirectory(_fs, path);
    return path;
  }

  @override
  FileStat statSync() {
    throw UnimplementedError('ArchiveDirectory.statSync');
  }

  @override
  Uri get uri => Uri.file(path);

  @override
  Stream<FileSystemEvent> watch(
      {int events = FileSystemEvent.all, bool recursive = false}) {
    throw UnimplementedError('ArchiveDirectory.watch');
  }
}

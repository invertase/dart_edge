part of edge_io.memory;

class MemoryFsEntity implements FileSystemEntity {
  final MemoryFsOverrides overrides;
  final String path;

  MemoryFsEntity(this.overrides, this.path);

  /// Cached list of segments in the path.
  List<String>? _cachedSegments;

  /// Returns the segments in the path.
  List<String> get _segments => _cachedSegments ??= path.split('/');

  /// Returns the parent node of the file.
  MemoryFsImplementation? get _parentNode {
    if (_segments.length == 1) {
      return null;
    }

    final parentPath = _segments.sublist(0, _segments.length - 1).join('/');
    return overrides._entities.get<MemoryFsImplementation>(parentPath);
  }

  @override
  // TODO: implement absolute
  FileSystemEntity get absolute => throw UnimplementedError();

  @override
  Future<FileSystemEntity> delete({bool recursive = false}) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  void deleteSync({bool recursive = false}) {
    overrides._entities.remove(path);
  }

  @override
  Future<bool> exists() {
    return Future.value(existsSync());
  }

  @override
  bool existsSync() {
    return overrides._entities.get(path) != null;
  }

  @override
  bool get isAbsolute => true;

  @override
  Directory get parent => throw UnimplementedError();

  @override
  Future<FileSystemEntity> rename(String newPath) {
    // TODO: implement rename
    throw UnimplementedError();
  }

  @override
  FileSystemEntity renameSync(String newPath) {
    // TODO: implement renameSync
    throw UnimplementedError();
  }

  @override
  Future<String> resolveSymbolicLinks() {
    // TODO: implement resolveSymbolicLinks
    throw UnimplementedError();
  }

  @override
  String resolveSymbolicLinksSync() {
    // TODO: implement resolveSymbolicLinksSync
    throw UnimplementedError();
  }

  @override
  Future<FileStat> stat() {
    // TODO: implement stat
    throw UnimplementedError();
  }

  @override
  FileStat statSync() {
    // TODO: implement statSync
    throw UnimplementedError();
  }

  @override
  // TODO: implement uri
  Uri get uri => throw UnimplementedError();

  @override
  Stream<FileSystemEvent> watch(
      {int events = FileSystemEvent.all, bool recursive = false}) {
    // TODO: implement watch
    throw UnimplementedError();
  }
}

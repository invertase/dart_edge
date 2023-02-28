part of edge_io.memory;

abstract class MemoryFsEntity implements FileSystemEntity {
  final MemoryFileSystem _fs;

  @override
  final String path;

  MemoryFsEntity(this._fs, this.path);

  /// Cached list of segments in the path.
  List<String>? _cachedSegments;

  /// Returns the segments in the path.
  List<String> get _segments => _cachedSegments ??= path.split('/');

  /// Returns the parent node of the entity.
  MemoryFsImplementation? get _parentNode {
    if (_segments.length == 1) {
      return null;
    }

    final parentPath = _segments.sublist(0, _segments.length - 1).join('/');
    return _fs.get<MemoryFsImplementation>(parentPath);
  }

  @override
  FileSystemEntity get absolute => throw UnimplementedError();

  @override
  Future<FileSystemEntity> delete({bool recursive = false}) async {
    deleteSync(recursive: recursive);
    return this;
  }

  @override
  void deleteSync({bool recursive = false}) {
    _fs.remove(path);
  }

  @override
  Future<bool> exists() {
    return Future.value(existsSync());
  }

  @override
  bool existsSync();

  @override
  bool get isAbsolute => true;

  @override
  Directory get parent {
    if (_parentNode == null) {
      return Directory('.');
    }

    return Directory(_segments.sublist(0, _segments.length - 1).join('/'));
  }

  @override
  Future<FileSystemEntity> rename(String newPath) {
    return Future.value(renameSync(newPath));
  }

  @override
  FileSystemEntity renameSync(String newPath);

  @override
  Future<String> resolveSymbolicLinks() {
    return Future.value(resolveSymbolicLinksSync());
  }

  @override
  String resolveSymbolicLinksSync();

  @override
  Future<FileStat> stat() {
    return Future.value(statSync());
  }

  @override
  FileStat statSync();

  @override
  Uri get uri => Uri.file(path);

  @override
  Stream<FileSystemEvent> watch(
      {int events = FileSystemEvent.all, bool recursive = false});
}

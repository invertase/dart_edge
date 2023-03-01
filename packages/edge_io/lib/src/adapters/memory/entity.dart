part of edge_io.memory;

/// An in-memory implementation of [FileSystemEntity].
abstract class MemoryFsEntity implements FileSystemEntity {
  final MemoryFileSystem _fs;

  @override
  final String path;

  MemoryFsEntity(this._fs, this.path);

  @override
  FileSystemEntity get absolute;

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
    return Directory(p.dirname(path));
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

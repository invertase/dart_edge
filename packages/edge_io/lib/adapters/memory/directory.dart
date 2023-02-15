part of edge_io.memory;

class MemoryDirectory extends MemoryFsEntity implements Directory {
  MemoryDirectory._(super.overrides, super.path);

  @override
  Future<Directory> rename(String newPath) {
    return Future.value(renameSync(newPath));
  }

  @override
  Directory renameSync(String newPath) {
    throw UnimplementedError();
  }

  @override
  Directory get absolute => throw UnimplementedError();

  @override
  Future<Directory> create({bool recursive = false}) async {
    createSync(recursive: recursive);
    return this;
  }

  @override
  void createSync({bool recursive = false}) {}

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
    // TODO: implement list
    throw UnimplementedError();
  }

  @override
  List<FileSystemEntity> listSync(
      {bool recursive = false, bool followLinks = true}) {
    // TODO: implement listSync
    throw UnimplementedError();
  }
}

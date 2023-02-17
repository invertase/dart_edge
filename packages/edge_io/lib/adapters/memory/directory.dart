part of edge_io.memory;

class MemoryDirectory extends MemoryFsEntity implements Directory {
  MemoryDirectory._(super.overrides, super.path);

  @override
  Future<Directory> rename(String newPath) {
    return Future.value(renameSync(newPath));
  }

  @override
  Directory renameSync(String newPath) {
    final existing =
        overrides._entities.get<MemoryDirectoryImplementation>(path);

    if (existing == null) {
      throw PathNotFoundException(
        path,
        OSError("No such file or directory", 2),
        "Rename failed",
      );
    }

    overrides._entities.remove(path); // Remove the old directory.
    overrides._entities.set(newPath, existing);

    return MemoryDirectory._(overrides, newPath);
  }

  @override
  Directory get absolute => throw UnimplementedError();

  @override
  Future<Directory> create({bool recursive = false}) async {
    createSync(recursive: recursive);
    return this;
  }

  @override
  void createSync({bool recursive = false}) {
    // If recursive is false, we should check whether this directory has a parent,
    // and if not, throw an error.
    if (!recursive && _segments.length > 1 && _parentNode == null) {
      throw PathNotFoundException(
        path,
        OSError("No such file or directory", 2),
        "Creation failed",
      );
    }

    final existing =
        overrides._entities.get<MemoryDirectoryImplementation>(path);

    if (existing != null) {
      return;
    }

    overrides._entities.set(path, MemoryDirectoryImplementation());
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
    final existing =
        overrides._entities.get<MemoryDirectoryImplementation>(path);

    if (existing == null) {
      throw PathNotFoundException(
        path,
        OSError("No such file or directory", 2),
        "Directory listing failed",
      );
    }

    final map = overrides._entities.toMap();
    final entities = <FileSystemEntity>[];

    if (_parentNode == null) {
      return entities;
    }

    // TODO implement me

    return entities;
  }
}

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

    FileSystemEntity toEntity(MemoryFsImplementation impl) {
      if (impl is MemoryFileImplementation) {
        return MemoryFile._(overrides, path);
      } else if (impl is MemoryDirectoryImplementation) {
        return MemoryDirectory._(overrides, path);
      } else {
        throw StateError("Unknown entity type");
      }
    }

    // TODO: followLinks
    if (recursive) {
      for (final entry in map.entries) {
        if (entry.key.startsWith(path)) {
          entities.add(toEntity(entry.value!));
        }
      }
    } else {
      for (final entry in map.entries) {
        if (entry.key.startsWith(path) &&
            entry.key.split("/").length == path.split("/").length + 1) {
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
    return MemoryFileStat(overrides, path);
  }

  @override
  Stream<FileSystemEvent> watch(
      {int events = FileSystemEvent.all, bool recursive = false}) {
    throw UnimplementedError('Directory.watch');
  }
}

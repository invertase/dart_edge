part of edge_io.fs.map_based;

/// Ensures that the node exists.
T assertExists<T extends MapBasedFsImplementation>(
    MapBasedFileSystem fs, String path,
    [String message = ""]) {
  final current = fs.get<T>(path);

  if (current == null) {
    throw PathNotFoundException(
      path,
      OSError("No such file or directory", 2),
      message,
    );
  }

  return current;
}

/// Ensures that the node exists.
void assertFileDoesNotExist<T extends MapBasedFsImplementation>(
    MapBasedFileSystem fs, String path,
    [String message = ""]) {
  final current = fs.get<T>(path);

  if (current != null) {
    throw FileSystemException(
      message,
      path,
      OSError("File exists", 17),
    );
  }
}

/// Ensures that the file exists and is a file, throwing a [FileSystemException]
/// if it is not.
T assertIsFile<T extends MapBasedFsFileImplementation>(
    MapBasedFileSystem fs, String path,
    [String message = ""]) {
  final impl = assertExists(fs, path, message);

  if (impl is! T) {
    throw FileSystemException(
      message,
      path,
      OSError("Not a file", 21),
    );
  }

  return impl;
}

/// Ensures that the directory exists and is a file, throwing a [FileSystemException]
/// if it is not.
T assertIsDirectory<T extends MapBasedFsDirectoryImplementation>(
    MapBasedFileSystem fs, String path,
    [String message = ""]) {
  final impl = assertExists(fs, path, message);

  if (impl is! T) {
    throw FileSystemException(
      message,
      path,
      OSError("Not a directory", 21),
    );
  }

  return impl;
}

/// Ensures that the directory exists and is a file, throwing a [FileSystemException]
/// if it is not.
MapBasedFsDirectoryImplementation assertDirectoryIsEmpty(
    MapBasedFileSystem fs, String path,
    [String message = ""]) {
  final dir = assertIsDirectory(fs, path, message);

  for (final key in fs.toMap().keys) {
    if (key.startsWith(path) && key != path) {
      throw FileSystemException(
        message,
        path,
        OSError("Directory not empty", 66),
      );
    }
  }

  return dir;
}

/// Asserts that the given path has a parent, which is a directory.
MapBasedFsDirectoryImplementation assertParentDirectory(
    MapBasedFileSystem fs, String path,
    [String message = ""]) {
  final parent = fs.get<MapBasedFsDirectoryImplementation>(p.dirname(path));

  if (parent == null) {
    throw FileSystemException(
      message,
      path,
      OSError("Not a directory", 20),
    );
  }

  return parent;
}

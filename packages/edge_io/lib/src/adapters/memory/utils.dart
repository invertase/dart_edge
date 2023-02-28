import 'dart:io';

import 'package:path/path.dart' as p;
import 'file_system.dart';
import 'impl/directory_impl.dart';
import 'impl/file_impl.dart';
import 'impl/implementation.dart';

/// Ensures that the node exists.
T assertExists<T extends MemoryFsImplementation>(
    MemoryFileSystem fs, String path,
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
void assertFileDoesNotExist<T extends MemoryFsImplementation>(
    MemoryFileSystem fs, String path,
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
MemoryFileImplementation assertIsFile(MemoryFileSystem fs, String path,
    [String message = ""]) {
  final impl = assertExists(fs, path, message);

  if (impl is! MemoryFileImplementation) {
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
MemoryDirectoryImplementation assertIsDirectory(
    MemoryFileSystem fs, String path,
    [String message = ""]) {
  final impl = assertExists(fs, path, message);

  if (impl is! MemoryDirectoryImplementation) {
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
MemoryDirectoryImplementation assertDirectoryIsEmpty(
    MemoryFileSystem fs, String path,
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

MemoryDirectoryImplementation assertParentDirectory(
    MemoryFileSystem fs, String path,
    [String message = ""]) {
  final parent = fs.get<MemoryDirectoryImplementation>(p.dirname(path));

  if (parent == null) {
    throw FileSystemException(
      message,
      path,
      OSError("Not a directory", 20),
    );
  }

  return parent;
}

import 'dart:io';

import 'package:archive/archive.dart';
import 'package:path/path.dart' as p;

ArchiveFile assertExists(Archive archive, String path, [String message = ""]) {
  return archive.files
      .firstWhere((element) => p.join('/', element.name) == path, orElse: () {
    throw PathNotFoundException(
      path,
      OSError("No such file or directory", 2),
      message,
    );
  });
}

ArchiveFile assertIsFile(Archive archive, String path, [String message = ""]) {
  return archive.files.firstWhere(
      (element) => p.join('/', element.name) == path && element.isFile,
      orElse: () {
    throw FileSystemException(
      message,
      path,
      OSError("Not a file", 21),
    );
  });
}

ArchiveFile assertIsDirectory(Archive archive, String path,
    [String message = ""]) {
  return archive.files.firstWhere(
      (element) => p.join('/', element.name) == path && !element.isFile,
      orElse: () {
    throw FileSystemException(
      message,
      path,
      OSError("Not a directory", 21),
    );
  });
}

import 'dart:io';

import 'package:path/path.dart' as p;

import 'package:edge_io/fs_adapter_platform_interface.dart';

import 'memory_directory.dart';
import 'memory_fs.dart';

class MemoryFSAdapter implements PlatformFSAdapter<MemoryFS> {
  @override
  late final MemoryFS fs;

  MemoryFSAdapter({String cwd = '/'}) : fs = MemoryFS(cwd: cwd);

  @override
  FileSystemEntity createEntity(String path, FileSystemEntityType type) {
    switch (type) {
      case FileSystemEntityType.directory:
        return MemoryDirectory(fs, path);
      default:
        throw FileSystemException('Unsupported entity type $type', path);
    }
  }

  @override
  Directory getCurrentDirectory() {
    return fs.cwd;
  }

  @override
  Directory getSystemTempDirectory() {
    return MemoryDirectory(fs, '/tmp');
  }

  @override
  FileSystemEntityType getType(String path, bool followLinks) {
    final entity = fs.getEntity(path);

    if (entity == null) {
      return FileSystemEntityType.notFound;
    }

    return entity.type;
  }

  @override
  bool identical(String path1, String path2) {
    final e1 = fs.getEntity(path1);
    final e2 = fs.getEntity(path2);

    if (e1 == null || e2 == null) {
      return false;
    }

    return e1 == e2;
  }

  @override
  void setCurrentDirectory(String path) {
    fs.cwd = Directory(p.join(fs.cwd.path, path));
  }

  @override
  FileStat stat(String path) {
    final entity = fs.getEntity(path);

    if (entity == null) {
      throw FileSystemException('No such file or directory', path);
    }

    return fs.stat(entity);
  }

  @override
  Stream<FileSystemEvent> watch(String path, int events, bool recursive) {
    // TODO: implement watch
    throw UnimplementedError();
  }

  @override
  bool watchIsSupported() {
    // TODO: implement watchIsSupported
    throw UnimplementedError();
  }
}

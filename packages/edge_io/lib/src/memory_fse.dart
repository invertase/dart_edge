import 'dart:io';
import 'package:edge_io/file_system_platform_interface.dart';
import 'package:path/path.dart' as p;

import 'memory_stat.dart';

abstract class MemoryFSE<T extends FileSystemEntity> extends FileSystemEntity {
  late final String _absolutePath;

  @override
  final String path;
  final FileSystemEntityType type;
  final FileSystemPlatform fs;
  late final MemoryStat stats = MemoryStat(this);

  MemoryFSE(this.fs, this.path, this.type) {
    _absolutePath = p.join(Directory.current.path, path);
  }

  T ctor(String path);

  @override
  T get absolute => ctor(_absolutePath);

  @override
  Future<bool> exists() async {
    return fs.exists(_absolutePath, type);
  }

  @override
  bool existsSync() {
    return fs.exists(_absolutePath, type);
  }

  @override
  Future<T> rename(String newPath) async {
    return fs.rename<T>(_absolutePath, newPath);
  }

  @override
  T renameSync(String newPath) {
    return fs.rename<T>(_absolutePath, newPath);
  }

  int get size;
}

import 'dart:io';
import 'package:edge_io/src/memory_directory.dart';
import 'package:edge_io/src/memory_fse.dart';
import 'package:path/path.dart' as p;

import 'package:edge_io/file_system_platform_interface.dart';

class _Entities {
  final Map<String, MemoryFSE> _pathsMap = {};

  bool has(String path) {
    return _pathsMap.containsKey(p.join(Directory.current.path, path));
  }

  MemoryFSE? operator [](String path) {
    return _pathsMap[p.join(Directory.current.path, path)];
  }

  void operator []=(String path, MemoryFSE entity) {
    final absolutePath = p.join(Directory.current.path, path);
    _pathsMap[absolutePath] = entity;
  }

  MemoryFSE? remove(String path) {
    return _pathsMap.remove(p.join(Directory.current.path, path));
  }

  Iterable<MemoryFSE> list(
    String prefix, {
    bool recursive = false,
    bool followSymlinks = true,
  }) sync* {
    final absolutePrefix = p.join(Directory.current.path, prefix);

    for (final entry in _pathsMap.entries) {
      if (entry.key == absolutePrefix) continue;
      if (!entry.key.startsWith(absolutePrefix)) continue;

      switch (entry.value.type) {
        case FileSystemEntityType.directory:
          if (recursive) yield* (entry.value as MemoryDirectory).listSync();
          break;
        case FileSystemEntityType.file:
          yield entry.value;
          break;
        case FileSystemEntityType.link:
          if (followSymlinks) {
            yield* list(entry.value.path, recursive: recursive);
          }
          break;
        default:
          continue;
      }
    }
  }
}

class MemoryFS extends FileSystemPlatform {
  @override
  late Directory cwd;

  final _Entities _entities = _Entities();

  MemoryFS({String cwd = '/'}) : cwd = Directory(p.absolute(cwd));

  @override
  bool exists(String path, FileSystemEntityType type) {
    final entity = _entities[path];
    return entity?.type == type;
  }

  @override
  T rename<T extends FileSystemEntity>(String path, String newPath) {
    final entity = _entities.remove(path);

    try {
      if (entity == null) {
        throw FileSystemException('No such file or directory', path);
      }

      final dstEntity = _entities[newPath];

      if (dstEntity == null) {
        _entities[newPath] = entity;
        return entity as T;
      }

      if (dstEntity.type != entity.type) {
        throw FileSystemException('Incompatible file types', newPath);
      }

      if (dstEntity.type == FileSystemEntityType.directory) {
        if ((dstEntity as MemoryDirectory).listSync().isNotEmpty) {
          throw FileSystemException('Directory not empty', newPath);
        }
      }

      _entities[newPath] = entity;
      return entity as T;
    } finally {
      if (entity != null) {
        _entities[path] = entity;
      }
    }
  }

  @override
  T create<T extends FileSystemEntity>(
    String path,
    T entity, {
    bool recursive = false,
  }) {
    final parent = p.dirname(path);
    final parentExists = _entities.has(parent);

    if (!parentExists && !recursive) {
      throw FileSystemException('No such file or directory', parent);
    }

    if (_entities.has(path)) {
      throw FileSystemException('File exists', path);
    } else {
      _entities[path] = entity as MemoryFSE;
      return entity;
    }
  }

  @override
  T? getEntity<T extends FileSystemEntity>(String path) {
    return _entities[path] as T;
  }

  @override
  FileStat stat(MemoryFSE entity) {
    return entity.stats;
  }

  @override
  Iterable<T> list<T extends FileSystemEntity>(
    String path, {
    bool recursive = false,
    bool followLinks = true,
  }) {
    return _entities
        .list(path, recursive: recursive, followSymlinks: followLinks)
        .cast();
  }
}

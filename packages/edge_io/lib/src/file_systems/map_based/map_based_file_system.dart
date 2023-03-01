library edge_io.fs.map_based;

import 'dart:io';

import 'package:path/path.dart' as p;

part 'utils.dart';

class MapBasedFileSystem {
  /// The root node of the file system.
  final Map<String, MapBasedFsImplementation?> _nodes = {};

  /// The base path of the file system.
  final String basePath;

  /// Creates a new [MapBasedFileSystem] instance.
  MapBasedFileSystem(String basePath) : basePath = p.join('/', basePath) {
    _init();
  }

  void _init() {
    setRecursively(basePath, MapBasedFsDirectoryImplementation());
  }

  /// Clears the file system.
  void clear() {
    _nodes.clear();
    _init();
  }

  String resolve(String path) {
    // TODO(ehesp): Should we be normalizing the path here?
    return p.normalize(p.join(basePath, path));
  }

  /// Removes a node from the file system.
  void remove(String path) {
    // You can't delete non-empty directories, so this should be fine.
    _nodes.remove(resolve(path));
  }

  /// Sets a node in the file system.
  void set(String path, MapBasedFsImplementation impl) {
    _nodes[resolve(path)] = impl;
  }

  /// Sets a node in the file system, and creates any parent directories.
  void setRecursively(String path, MapBasedFsImplementation impl) {
    final chunks = p.split(path);

    for (var i = 0; i < chunks.length; i++) {
      final currentPath = p.joinAll(chunks.sublist(0, i + 1));

      if (i == chunks.length - 1) {
        set(path, impl);
      } else {
        if (get(currentPath) != null) {
          assertIsDirectory(this, currentPath);
        } else {
          set(currentPath, MapBasedFsDirectoryImplementation());
        }
      }
    }

    _nodes[resolve(path)] = impl;
  }

  /// Gets a node from the file system, or null if it doesn't exist.
  ///
  /// This also accepts an optional type to check the node is of the correct type.
  T? get<T extends MapBasedFsImplementation>(String path) {
    final impl = _nodes[resolve(path)];

    if (impl is! T) {
      return null;
    }

    return impl;
  }

  /// Returns the raw [Map] of nodes.
  Map<String, MapBasedFsImplementation?> toMap() {
    return _nodes;
  }
}

abstract class MapBasedFsImplementation {}

/// A stub-directory implementation.
class MapBasedFsDirectoryImplementation extends MapBasedFsImplementation {}

/// A stub-directory implementation.
class MapBasedFsFileImplementation extends MapBasedFsImplementation {}

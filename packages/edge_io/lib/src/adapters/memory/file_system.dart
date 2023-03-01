import 'package:path/path.dart' as p;
import 'impl/directory_impl.dart';
import 'impl/implementation.dart';
import 'utils.dart';

/// An im-memory [Map] based file system.
class MemoryFileSystem {
  /// The base path of the file system.
  final String basePath;

  /// Creates a new [MemoryFileSystem] instance.
  MemoryFileSystem(this.basePath) {
    _init();
  }

  /// Initializes the file system.
  _init() {
    // Setup the structure of the file system, using the base path as the root.
    setRecursively(basePath, MemoryDirectoryImplementation());
  }

  /// A [Map] of all nodes in the file system.
  final Map<String, MemoryFsImplementation?> _nodes = {};

  /// Clears the file system, and resets any base path nodes.
  void clear() {
    _nodes.clear();
    _init();
  }

  /// Resolves and normalizes a path to the provided base path.
  String resolve(String path) {
    // TODO(ehesp): Should we be normalizing the path here?
    return p.normalize(p.join(basePath, path));
  }

  /// Removes a node from the file system.
  void remove(String path) {
    _nodes.remove(resolve(path));
  }

  /// Sets a node in the file system.
  void set(String path, MemoryFsImplementation impl) {
    _nodes[resolve(path)] = impl;
  }

  ///  Sets a node in the file system, and creates any parent directories.
  void setRecursively(String path, MemoryFsImplementation impl) {
    final chunks = p.split(path);

    for (var i = 0; i < chunks.length; i++) {
      final currentPath = p.joinAll(chunks.sublist(0, i + 1));

      if (i == chunks.length - 1) {
        set(path, impl);
      } else {
        if (get(currentPath) != null) {
          assertIsDirectory(this, currentPath);
        }

        set(currentPath, MemoryDirectoryImplementation());
      }
    }

    _nodes[resolve(path)] = impl;
  }

  /// Gets a node from the file system, or null if it doesn't exist.
  ///
  /// This also accepts an optional type to check the node is of the correct type.
  T? get<T extends MemoryFsImplementation>(String path) {
    final impl = _nodes[resolve(path)];

    if (impl is! T) {
      return null;
    }

    return impl;
  }

  /// Returns the raw [Map] of nodes.
  Map<String, MemoryFsImplementation?> toMap() {
    return _nodes;
  }
}

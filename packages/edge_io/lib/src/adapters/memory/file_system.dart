import 'package:path/path.dart' as p;
import 'impl/directory_impl.dart';
import 'impl/implementation.dart';
import 'utils.dart';

class MemoryFileSystem {
  final String basePath;

  MemoryFileSystem(this.basePath);

  final Map<String, MemoryFsImplementation?> _entities = {};

  void clear() {
    _entities.clear();
  }

  String join(String path) {
    return p.join(basePath, path);
  }

  void remove(String path) {
    _entities.remove(join(path));
  }

  void set(String path, MemoryFsImplementation impl) {
    _entities[join(path)] = impl;
  }

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

    _entities[join(path)] = impl;
  }

  T? get<T extends MemoryFsImplementation>(String path) {
    final impl = _entities[join(path)];

    if (impl is! T) {
      return null;
    }

    return impl;
  }

  Map<String, MemoryFsImplementation?> toMap() {
    return _entities;
  }
}

part of edge_io.memory;

/// An in-memory implementation of [FileStat].
class MemoryFileStat implements FileStat {
  final MemoryFileSystem _fs;
  final String _path;
  final MemoryFsImplementation? _impl;

  /// Creates a new [MemoryFileStat] instance.
  MemoryFileStat(this._fs, String path)
      : _path = _fs.resolve(path),
        _impl = _fs.get(path);

  DateTime get _defaultDateTime => DateTime.fromMillisecondsSinceEpoch(0);

  @override
  DateTime get accessed {
    if (_impl == null) {
      return _defaultDateTime;
    }

    if (_impl is MemoryFileImplementation) {
      return (_impl as MemoryFileImplementation).lastAccessed;
    }

    if (_impl is MemoryDirectoryImplementation) {
      return DateTime.now();
    }

    throw UnimplementedError();
  }

  @override
  DateTime get modified {
    if (_impl == null) {
      return _defaultDateTime;
    }

    if (_impl is MemoryFileImplementation) {
      return (_impl as MemoryFileImplementation).lastModified;
    }

    if (_impl is MemoryDirectoryImplementation) {
      // TODO(ehesp): This probably isn't correct.
      return DateTime.now();
    }

    throw UnimplementedError();
  }

  @override
  DateTime get changed {
    if (_impl == null) {
      return _defaultDateTime;
    }

    if (_impl is MemoryFileImplementation) {
      return (_impl as MemoryFileImplementation).changed;
    }

    if (_impl is MemoryDirectoryImplementation) {
      // TODO(ehesp): This probably isn't correct.
      return DateTime.now();
    }

    throw UnimplementedError();
  }

  @override
  int get mode => 777; // TODO: Do we care about this?

  @override
  String modeString() {
    if (_impl == null) {
      return '---------';
    }

    var permissions = mode & 0xFFF;
    var codes = const ['---', '--x', '-w-', '-wx', 'r--', 'r-x', 'rw-', 'rwx'];
    var result = [];
    if ((permissions & 0x800) != 0) result.add("(suid) ");
    if ((permissions & 0x400) != 0) result.add("(guid) ");
    if ((permissions & 0x200) != 0) result.add("(sticky) ");
    result
      ..add(codes[(permissions >> 6) & 0x7])
      ..add(codes[(permissions >> 3) & 0x7])
      ..add(codes[permissions & 0x7]);
    return result.join();
  }

  @override
  int get size {
    if (_impl == null) {
      return -1;
    }

    if (_impl is MemoryFileImplementation) {
      return (_impl as MemoryFileImplementation).bytes.length;
    }

    if (_impl is MemoryDirectoryImplementation) {
      int size = 0;

      for (final entry in _fs.toMap().entries) {
        if (entry.key.startsWith(_path) && entry.key != _path) {
          if (entry.value is MemoryFileImplementation) {
            size += (entry.value as MemoryFileImplementation).bytes.length;
          }
        }
      }

      return size;
    }

    throw UnimplementedError(
        'TODO: implement size for MemoryDirectoryImplementation');
  }

  @override
  FileSystemEntityType get type {
    if (_impl is MemoryDirectoryImplementation) {
      return FileSystemEntityType.directory;
    }

    if (_impl is MemoryFileImplementation) {
      return FileSystemEntityType.file;
    }

    // TODO(ehesp): Handle links
    // if (_impl is MemoryLink) {
    //   return FileSystemEntityType.link;
    // }

    return FileSystemEntityType.notFound;
  }
}

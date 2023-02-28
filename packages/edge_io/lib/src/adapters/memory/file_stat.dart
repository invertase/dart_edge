part of edge_io.memory;

class MemoryFileStat implements FileStat {
  final MemoryFileSystem _fs;
  final String _path;
  final MemoryFsImplementation? _impl;

  MemoryFileStat(this._fs, this._path) : _impl = _fs.get(_path);

  DateTime get defaultDateTime => DateTime.fromMillisecondsSinceEpoch(0);

  @override
  DateTime get accessed {
    if (_impl == null) {
      return defaultDateTime;
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
      return defaultDateTime;
    }

    if (_impl is MemoryFileImplementation) {
      return (_impl as MemoryFileImplementation).lastModified;
    }

    if (_impl is MemoryDirectoryImplementation) {
      return DateTime.now();
    }

    throw UnimplementedError();
  }

  @override
  DateTime get changed {
    if (_impl == null) {
      return defaultDateTime;
    }

    if (_impl is MemoryFileImplementation) {
      return (_impl as MemoryFileImplementation).changed;
    }

    if (_impl is MemoryDirectoryImplementation) {
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

    // if (_impl is MemoryLink) {
    //   return FileSystemEntityType.link;
    // }

    return FileSystemEntityType.notFound;
  }
}

part of edge_io.memory;

class MemoryRandomAccessFile implements RandomAccessFile {
  final MapBasedFileSystem _fs;
  final String _path;
  final FileMode _mode;

  final MemoryFileImplementation _file;

  MemoryRandomAccessFile(
    this._fs,
    this._path, {
    required FileMode mode,
  })  : _mode = mode,
        _file = _fs.get<MemoryFileImplementation>(_path)!;

  bool _isOpen = true;
  int _position = 0;

  @override
  Future<void> close() async {
    closeSync();
  }

  @override
  void closeSync() {
    _assertIsOpen();
    _isOpen = false;
  }

  @override
  Future<RandomAccessFile> flush() async {
    flushSync();
    return this;
  }

  @override
  void flushSync() {
    _assertIsOpen();
  }

  @override
  Future<int> length() {
    return Future.value(lengthSync());
  }

  @override
  int lengthSync() {
    _assertIsOpen();
    return _file.bytes.length;
  }

  @override
  Future<RandomAccessFile> lock(
      [FileLock mode = FileLock.exclusive, int start = 0, int end = -1]) async {
    lockSync(mode, start, end);
    return this;
  }

  @override
  void lockSync(
      [FileLock mode = FileLock.exclusive, int start = 0, int end = -1]) {
    throw UnimplementedError('RandomAccessFile.lockSync');
  }

  @override
  String get path => _fs.resolve(_path);

  @override
  Future<int> position() {
    return Future.value(positionSync());
  }

  @override
  int positionSync() {
    _assertIsOpen();
    return _position;
  }

  @override
  Future<Uint8List> read(int count) {
    return Future.value(readSync(count));
  }

  @override
  Uint8List readSync(int count) {
    _assertIsOpen();
    _assertIsReadable('readSync');
    final int end = math.min(_position + count, lengthSync());
    final copy = _file.bytes.sublist(_position, end);
    _position = end;
    return Uint8List.fromList(copy);
  }

  @override
  Future<int> readByte() {
    return Future.value(readByteSync());
  }

  @override
  int readByteSync() {
    _assertIsOpen();
    _assertIsReadable('readByteSync');

    if (_position >= lengthSync()) {
      throw FileSystemException('Cannot readByte at end of file', path);
    }

    return _file.bytes[_position++];
  }

  @override
  Future<int> readInto(List<int> buffer, [int start = 0, int? end]) {
    return Future.value(readIntoSync(buffer, start, end));
  }

  @override
  int readIntoSync(List<int> buffer, [int start = 0, int? end]) {
    _assertIsOpen();
    _assertIsReadable('readIntoSync');

    end = RangeError.checkValidRange(start, end, buffer.length);

    final int length = lengthSync();
    int i;
    for (i = start; i < end && _position < length; i += 1, _position += 1) {
      buffer[i] = _file.bytes[_position];
    }
    return i - start;
  }

  @override
  Future<RandomAccessFile> setPosition(int position) async {
    setPositionSync(position);
    return this;
  }

  @override
  void setPositionSync(int position) {
    _assertIsOpen();

    if (position < 0) {
      throw ArgumentError.value(position, 'position', 'must be non-negative');
    }

    _position = position;
  }

  @override
  Future<RandomAccessFile> truncate(int length) async {
    truncateSync(length);
    return this;
  }

  @override
  void truncateSync(int length) {
    _assertIsOpen();
    _assertIsWriteable('truncateSync');

    if (length < 0) {
      throw ArgumentError.value(length, 'length', 'must be non-negative');
    }

    throw UnimplementedError('RandomAccessFile.truncateSync');
  }

  @override
  Future<RandomAccessFile> unlock([int start = 0, int end = -1]) async {
    unlockSync(start, end);
    return this;
  }

  @override
  void unlockSync([int start = 0, int end = -1]) {
    throw UnimplementedError('RandomAccessFile.unlockSync');
  }

  @override
  Future<RandomAccessFile> writeByte(int value) async {
    writeByteSync(value);
    return this;
  }

  @override
  int writeByteSync(int value) {
    _assertIsOpen();
    _assertIsWriteable('writeByteSync');
    throw UnimplementedError('RandomAccessFile.writeByteSync');
  }

  @override
  Future<RandomAccessFile> writeFrom(List<int> buffer,
      [int start = 0, int? end]) async {
    writeFromSync(buffer, start, end);
    return this;
  }

  @override
  void writeFromSync(List<int> buffer, [int start = 0, int? end]) {
    _assertIsOpen();
    _assertIsWriteable('writeFromSync');
    throw UnimplementedError();
  }

  @override
  Future<RandomAccessFile> writeString(String string,
      {Encoding encoding = utf8}) async {
    writeStringSync(string, encoding: encoding);
    return this;
  }

  @override
  void writeStringSync(String string, {Encoding encoding = utf8}) {
    writeFromSync(encoding.encode(string));
  }

  void _assertIsOpen() {
    if (!_isOpen) {
      throw FileSystemException('File closed', _path);
    }
  }

  void _assertIsReadable(String operation) {
    switch (_mode) {
      case FileMode.read:
      case FileMode.write:
      case FileMode.append:
        break;
      default:
        // TODO better error
        throw FileSystemException('$operation failed');
    }
  }

  void _assertIsWriteable(String operation) {
    switch (_mode) {
      case FileMode.write:
      case FileMode.append:
      case FileMode.writeOnly:
      case FileMode.writeOnlyAppend:
        break;
      default:
        // TODO better error
        throw FileSystemException('$operation failed');
    }
  }
}

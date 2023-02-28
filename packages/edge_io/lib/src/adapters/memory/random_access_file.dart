import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:edge_io/src/adapters/memory/file_system.dart';

class MemoryRandomAccessFile implements RandomAccessFile {
  final MemoryFileSystem _fs;
  final String _path;
  final FileMode _mode;

  MemoryRandomAccessFile(
    this._fs,
    this._path, {
    required FileMode mode,
  }) : _mode = mode;

  bool _isOpen = true;
  int _position = 0;

  @override
  Future<void> close() async {
    closeSync();
  }

  @override
  void closeSync() {}

  @override
  Future<RandomAccessFile> flush() async {
    flushSync();
    return this;
  }

  @override
  void flushSync() {
    throw UnimplementedError();
  }

  @override
  Future<int> length() {
    return Future.value(lengthSync());
  }

  @override
  int lengthSync() {
    // TODO: implement lengthSync
    throw UnimplementedError();
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
    // TODO: implement lockSync
    throw UnimplementedError();
  }

  @override
  String get path => throw UnimplementedError();

  @override
  Future<int> position() {
    return Future.value(positionSync());
  }

  @override
  int positionSync() {
    throw UnimplementedError();
  }

  @override
  Future<Uint8List> read(int count) {
    return Future.value(readSync(count));
  }

  @override
  Uint8List readSync(int count) {
    throw UnimplementedError();
  }

  @override
  Future<int> readByte() {
    return Future.value(readByteSync());
  }

  @override
  int readByteSync() {
    throw UnimplementedError();
  }

  @override
  Future<int> readInto(List<int> buffer, [int start = 0, int? end]) {
    return Future.value(readIntoSync(buffer, start, end));
  }

  @override
  int readIntoSync(List<int> buffer, [int start = 0, int? end]) {
    throw UnimplementedError();
  }

  @override
  Future<RandomAccessFile> setPosition(int position) async {
    setPositionSync(position);
    return this;
  }

  @override
  void setPositionSync(int position) {
    throw UnimplementedError();
  }

  @override
  Future<RandomAccessFile> truncate(int length) async {
    truncateSync(length);
    return this;
  }

  @override
  void truncateSync(int length) {
    throw UnimplementedError();
  }

  @override
  Future<RandomAccessFile> unlock([int start = 0, int end = -1]) async {
    unlockSync(start, end);
    return this;
  }

  @override
  void unlockSync([int start = 0, int end = -1]) {
    throw UnimplementedError();
  }

  @override
  Future<RandomAccessFile> writeByte(int value) async {
    writeByteSync(value);
    return this;
  }

  @override
  int writeByteSync(int value) {
    throw UnimplementedError();
  }

  @override
  Future<RandomAccessFile> writeFrom(List<int> buffer,
      [int start = 0, int? end]) async {
    writeFromSync(buffer, start, end);
    return this;
  }

  @override
  void writeFromSync(List<int> buffer, [int start = 0, int? end]) {
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
    throw UnimplementedError();
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

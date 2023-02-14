library edge_io.memory;

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:path/path.dart' as p;
import 'impl/implementation.dart';
import 'impl/file_impl.dart';

part 'entity.dart';
// part 'directory.dart';
part 'file.dart';

class MemoryFsOverrides extends IOOverrides {
  final Entities _entities;

  MemoryFsOverrides({
    String? basePath,
  }) : _entities = Entities(basePath ?? '/');

  void clear() {
    _entities.clear();
  }

  @override
  Directory createDirectory(String path) {
    // return MemoryDirectory(this, path);
    throw UnimplementedError();
  }

  @override
  File createFile(String path) {
    return MemoryFile._(this, path);
  }

  @override
  Link createLink(String path) {
    // TODO: implement createLink
    throw UnimplementedError();
  }

  @override
  Stream<FileSystemEvent> fsWatch(String path, int events, bool recursive) {
    // TODO: implement fsWatch
    throw UnimplementedError();
  }

  @override
  bool fsWatchIsSupported() {
    // TODO: implement fsWatchIsSupported
    throw UnimplementedError();
  }

  @override
  Future<FileSystemEntityType> fseGetType(String path, bool followLinks) {
    // TODO: implement fseGetType
    throw UnimplementedError();
  }

  @override
  FileSystemEntityType fseGetTypeSync(String path, bool followLinks) {
    // TODO: implement fseGetTypeSync
    throw UnimplementedError();
  }

  @override
  Future<bool> fseIdentical(String path1, String path2) {
    // TODO: implement fseIdentical
    throw UnimplementedError();
  }

  @override
  bool fseIdenticalSync(String path1, String path2) {
    // TODO: implement fseIdenticalSync
    throw UnimplementedError();
  }

  @override
  Directory getCurrentDirectory() {
    // TODO: implement getCurrentDirectory
    throw UnimplementedError();
  }

  @override
  Directory getSystemTempDirectory() {
    // TODO: implement getSystemTempDirectory
    throw UnimplementedError();
  }

  @override
  Future<ServerSocket> serverSocketBind(address, int port,
      {int backlog = 0, bool v6Only = false, bool shared = false}) {
    // TODO: implement serverSocketBind
    throw UnimplementedError();
  }

  @override
  void setCurrentDirectory(String path) {
    // TODO: implement setCurrentDirectory
  }

  @override
  Future<Socket> socketConnect(host, int port,
      {sourceAddress, int sourcePort = 0, Duration? timeout}) {
    // TODO: implement socketConnect
    throw UnimplementedError();
  }

  @override
  Future<ConnectionTask<Socket>> socketStartConnect(host, int port,
      {sourceAddress, int sourcePort = 0}) {
    // TODO: implement socketStartConnect
    throw UnimplementedError();
  }

  @override
  Future<FileStat> stat(String path) {
    // TODO: implement stat
    throw UnimplementedError();
  }

  @override
  FileStat statSync(String path) {
    // TODO: implement statSync
    throw UnimplementedError();
  }

  @override
  Stdout get stderr => throw UnimplementedError();

  @override
  Stdin get stdin => throw UnimplementedError();

  @override
  Stdout get stdout => throw UnimplementedError();
}

class Entities {
  final String basePath;

  Entities(this.basePath);

  Map<String, MemoryFsImplementation?> _entities = {};

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

  T? get<T extends MemoryFsImplementation>(String path) {
    final impl = _entities[join(path)];

    if (impl == null) {
      return null;
    }

    if (impl is! T) {
      throw FileSystemException(
          'Entity at path is not a ${T.runtimeType}', path);
    }

    return impl;
  }
}

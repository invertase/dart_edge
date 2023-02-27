library edge_io.memory;

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:path/path.dart' as p;

import '../../streamed_io_sink.dart';
import '../../streamed_stdout.dart';
import 'impl/directory_impl.dart';
import 'impl/implementation.dart';
import 'impl/file_impl.dart';

part 'entity.dart';
part 'directory.dart';
part 'file.dart';
part 'file_stat.dart';

class MemoryFsOverrides extends IOOverrides {
  final Entities _entities;
  final Stdout _stdout;

  MemoryFsOverrides({
    String? basePath,
    Stdout? stdout,
  })  : _entities = Entities(basePath ?? '/'),
        _stdout = stdout ?? StreamedStdout();

  void clear() {
    _entities.clear();
  }

  @override
  Directory createDirectory(String path) {
    return MemoryDirectory._(this, path);
  }

  @override
  File createFile(String path) {
    return MemoryFile._(this, path);
  }

  @override
  Link createLink(String path) {
    throw UnimplementedError('MemoryFsOverrides.createLink');
  }

  @override
  Stream<FileSystemEvent> fsWatch(String path, int events, bool recursive) {
    throw UnimplementedError('MemoryFsOverrides.fsWatch');
  }

  @override
  bool fsWatchIsSupported() => false;

  @override
  Future<FileSystemEntityType> fseGetType(String path, bool followLinks) {
    return Future.value(fseGetTypeSync(path, followLinks));
  }

  @override
  FileSystemEntityType fseGetTypeSync(String path, bool followLinks) {
    final entity = _entities.get(path);

    if (entity is MemoryDirectoryImplementation) {
      return FileSystemEntityType.directory;
    }

    if (entity is MemoryFileImplementation) {
      return FileSystemEntityType.file;
    }

    return FileSystemEntityType.notFound;
  }

  @override
  Future<bool> fseIdentical(String path1, String path2) {
    return Future.value(fseIdenticalSync(path1, path2));
  }

  @override
  bool fseIdenticalSync(String path1, String path2) {
    // This is probably lazy...
    return path1 == path2;
  }

  @override
  Directory getCurrentDirectory() {
    return MemoryDirectory._(this, _entities.basePath);
  }

  @override
  Directory getSystemTempDirectory() {
    // TODO: implement getSystemTempDirectory
    throw UnimplementedError();
  }

  @override
  Future<ServerSocket> serverSocketBind(address, int port,
      {int backlog = 0, bool v6Only = false, bool shared = false}) {
    throw UnimplementedError('MemoryFsOverrides.serverSocketBind');
  }

  @override
  void setCurrentDirectory(String path) {
    throw UnimplementedError('MemoryFsOverrides.setCurrentDirectory');
  }

  @override
  Future<Socket> socketConnect(host, int port,
      {sourceAddress, int sourcePort = 0, Duration? timeout}) {
    throw UnimplementedError('MemoryFsOverrides.socketConnect');
  }

  @override
  Future<ConnectionTask<Socket>> socketStartConnect(host, int port,
      {sourceAddress, int sourcePort = 0}) {
    throw UnimplementedError('MemoryFsOverrides.socketStartConnect');
  }

  @override
  Future<FileStat> stat(String path) {
    return Future.value(MemoryFileStat(this, path));
  }

  @override
  FileStat statSync(String path) {
    return MemoryFileStat(this, path);
  }

  @override
  Stdout get stderr => _stdout;

  @override
  Stdin get stdin => throw UnimplementedError('MemoryFsOverrides.stdin');

  @override
  Stdout get stdout => _stdout;
}

class Entities {
  final String basePath;

  Entities(this.basePath);

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

  Map<String, MemoryFsImplementation?> toMap() {
    return _entities;
  }
}

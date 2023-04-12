import 'dart:io';

import 'package:edge_io/fs_adapter_platform_interface.dart';

import 'src/memory_fs_adapter.dart';

class EdgeIOOverrides implements IOOverrides {
  final PlatformFSAdapter fsAdapter;

  EdgeIOOverrides({
    PlatformFSAdapter? fsAdapter,
  }) : fsAdapter = fsAdapter ?? MemoryFSAdapter();

  @override
  Directory createDirectory(String path) {
    final entity = fsAdapter.createEntity(path, FileSystemEntityType.directory);
    return entity as Directory;
  }

  @override
  File createFile(String path) {
    return fsAdapter.createEntity(path, FileSystemEntityType.file) as File;
  }

  @override
  Link createLink(String path) {
    return fsAdapter.createEntity(path, FileSystemEntityType.link) as Link;
  }

  @override
  Stream<FileSystemEvent> fsWatch(String path, int events, bool recursive) {
    return fsAdapter.watch(path, events, recursive);
  }

  @override
  bool fsWatchIsSupported() {
    return fsAdapter.watchIsSupported();
  }

  @override
  Future<FileSystemEntityType> fseGetType(String path, bool followLinks) async {
    return fsAdapter.getType(path, followLinks);
  }

  @override
  FileSystemEntityType fseGetTypeSync(String path, bool followLinks) {
    return fsAdapter.getType(path, followLinks);
  }

  @override
  Future<bool> fseIdentical(String path1, String path2) async {
    return fsAdapter.identical(path1, path2);
  }

  @override
  bool fseIdenticalSync(String path1, String path2) {
    return fsAdapter.identical(path1, path2);
  }

  @override
  Directory getCurrentDirectory() {
    return fsAdapter.getCurrentDirectory();
  }

  @override
  Directory getSystemTempDirectory() {
    return fsAdapter.getSystemTempDirectory();
  }

  @override
  Future<ServerSocket> serverSocketBind(
    address,
    int port, {
    int backlog = 0,
    bool v6Only = false,
    bool shared = false,
  }) {
    // TODO: implement serverSocketBind
    throw UnimplementedError();
  }

  @override
  void setCurrentDirectory(String path) {
    fsAdapter.setCurrentDirectory(path);
  }

  @override
  Future<Socket> socketConnect(
    host,
    int port, {
    sourceAddress,
    int sourcePort = 0,
    Duration? timeout,
  }) {
    // TODO: implement socketConnect
    throw UnimplementedError();
  }

  @override
  Future<ConnectionTask<Socket>> socketStartConnect(
    host,
    int port, {
    sourceAddress,
    int sourcePort = 0,
  }) {
    // TODO: implement socketStartConnect
    throw UnimplementedError();
  }

  @override
  Future<FileStat> stat(String path) async {
    return fsAdapter.stat(path);
  }

  @override
  FileStat statSync(String path) {
    return fsAdapter.stat(path);
  }

  @override
  // TODO: implement stderr
  Stdout get stderr => throw UnimplementedError();

  @override
  // TODO: implement stdin
  Stdin get stdin => throw UnimplementedError();

  @override
  // TODO: implement stdout
  Stdout get stdout => throw UnimplementedError();
}

import 'dart:io';

import 'package:edge_io/src/interfaces/read_only/exceptions.dart';

import 'directory.dart';
import 'file.dart';

abstract class ReadOnlyFileSystem extends IOOverrides {
  @override
  ReadOnlyDirectory createDirectory(String path);

  @override
  ReadOnlyFile createFile(String path);

  @override
  Link createLink(String path);

  @override
  Stream<FileSystemEvent> fsWatch(String path, int events, bool recursive);

  @override
  bool fsWatchIsSupported();

  @override
  Future<ServerSocket> serverSocketBind(address, int port, {int backlog = 0, bool v6Only = false, bool shared = false}) {
    throw readOnlyException;
  }

  @override
  void setCurrentDirectory(String path) {
    throw readOnlyException;
  }

  @override
  Future<Socket> socketConnect(host, int port, {sourceAddress, int sourcePort = 0, Duration? timeout}) {
    throw readOnlyException;
  }

  @override
  Future<ConnectionTask<Socket>> socketStartConnect(host, int port, {sourceAddress, int sourcePort = 0}) {
    throw readOnlyException;
  }
}

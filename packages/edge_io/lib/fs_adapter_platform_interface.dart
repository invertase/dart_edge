import 'dart:io';

import 'package:edge_io/file_system_platform_interface.dart';

abstract class PlatformFSAdapter<T extends FileSystemPlatform> {
  const PlatformFSAdapter();

  T get fs;

  FileSystemEntity createEntity(String path, FileSystemEntityType type) {
    throw UnimplementedError();
  }

  Stream<FileSystemEvent> watch(String path, int events, bool recursive) {
    throw UnimplementedError();
  }

  bool watchIsSupported() {
    throw UnimplementedError();
  }

  FileSystemEntityType getType(String path, bool followLinks) {
    throw UnimplementedError();
  }

  bool identical(String path1, String path2) {
    throw UnimplementedError();
  }

  Directory getCurrentDirectory() {
    throw UnimplementedError();
  }

  Directory getSystemTempDirectory() {
    throw UnimplementedError();
  }

  void setCurrentDirectory(String path) {
    throw UnimplementedError();
  }

  FileStat stat(String path) {
    throw UnimplementedError();
  }
}

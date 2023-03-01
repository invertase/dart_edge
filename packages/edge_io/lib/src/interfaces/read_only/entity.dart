import 'dart:io';

import 'exceptions.dart';

abstract class ReadOnlyFsEntity implements FileSystemEntity {
  @override
  Future<FileSystemEntity> delete({bool recursive = false}) async {
    deleteSync(recursive: recursive);
    return this;
  }

  @override
  void deleteSync({bool recursive = false}) {
    throw readOnlyException;
  }

  @override
  Future<bool> exists() {
    return Future.value(existsSync());
  }

  @override
  bool existsSync();

  @override
  bool get isAbsolute;

  @override
  Directory get parent;

  @override
  String get path;

  @override
  Future<FileSystemEntity> rename(String newPath) {
    return Future.value(renameSync(newPath));
  }

  @override
  FileSystemEntity renameSync(String newPath) {
    throw readOnlyException;
  }

  @override
  Future<String> resolveSymbolicLinks() {
    return Future.value(resolveSymbolicLinksSync());
  }

  @override
  String resolveSymbolicLinksSync();

  @override
  Future<FileStat> stat() {
    return Future.value(statSync());
  }

  @override
  FileStat statSync();

  @override
  Uri get uri;

  @override
  Stream<FileSystemEvent> watch(
      {int events = FileSystemEvent.all, bool recursive = false});
}

import 'dart:io';

import 'package:edge_io/src/interfaces/read_only/entity.dart';

import 'exceptions.dart';

abstract class ReadOnlyDirectory extends ReadOnlyFsEntity implements Directory {
  @override
  Future<Directory> create({bool recursive = false}) {
    throw readOnlyException;
  }

  @override
  void createSync({bool recursive = false}) {
    throw readOnlyException;
  }

  @override
  Future<Directory> rename(String newPath) {
    throw readOnlyException;
  }

  @override
  Directory renameSync(String newPath) {
    throw readOnlyException;
  }

  @override
  Future<Directory> createTemp([String? prefix]) {
    throw readOnlyException;
  }

  @override
  Directory createTempSync([String? prefix]) {
    throw readOnlyException;
  }

  @override
  Future<bool> exists();

  @override
  bool existsSync();

  @override
  bool get isAbsolute;

  @override
  Stream<FileSystemEntity> list(
      {bool recursive = false, bool followLinks = true});

  @override
  List<FileSystemEntity> listSync(
      {bool recursive = false, bool followLinks = true});

  @override
  Directory get parent;

  @override
  String get path;

  @override
  Future<String> resolveSymbolicLinks();

  @override
  String resolveSymbolicLinksSync();

  @override
  Uri get uri;

  @override
  Future<FileStat> stat();

  @override
  FileStat statSync();

  @override
  Stream<FileSystemEvent> watch(
      {int events = FileSystemEvent.all, bool recursive = false});
}

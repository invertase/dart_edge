import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:edge_io/src/interfaces/read_only/entity.dart';
import 'package:edge_io/src/interfaces/read_only/exceptions.dart';

abstract class ReadOnlyFile extends ReadOnlyFsEntity implements File {
  @override
  File get absolute;

  @override
  Future<File> rename(String newPath) {
    throw readOnlyException;
  }

  @override
  File renameSync(String newPath) {
    throw readOnlyException;
  }

  @override
  Future<File> copy(String newPath) {
    throw readOnlyException;
  }

  @override
  File copySync(String newPath) {
    throw readOnlyException;
  }

  @override
  Future<File> create({bool recursive = false, bool exclusive = false}) {
    throw readOnlyException;
  }

  @override
  void createSync({bool recursive = false, bool exclusive = false}) {
    throw readOnlyException;
  }

  @override
  Future<bool> exists();

  @override
  bool existsSync();

  @override
  bool get isAbsolute;

  @override
  Future<DateTime> lastAccessed();

  @override
  DateTime lastAccessedSync();

  @override
  Future<DateTime> lastModified();

  @override
  DateTime lastModifiedSync();

  @override
  Future<int> length();

  @override
  int lengthSync();

  @override
  Future<RandomAccessFile> open({FileMode mode = FileMode.read});

  @override
  Stream<List<int>> openRead([int? start, int? end]);

  @override
  RandomAccessFile openSync({FileMode mode = FileMode.read});

  @override
  IOSink openWrite({FileMode mode = FileMode.write, Encoding encoding = utf8}) {
    throw readOnlyException;
  }

  @override
  Directory get parent;

  @override
  String get path;

  @override
  Future<Uint8List> readAsBytes();

  @override
  Uint8List readAsBytesSync();

  @override
  Future<List<String>> readAsLines({Encoding encoding = utf8});

  @override
  List<String> readAsLinesSync({Encoding encoding = utf8});

  @override
  Future<String> readAsString({Encoding encoding = utf8});

  @override
  String readAsStringSync({Encoding encoding = utf8});

  @override
  String resolveSymbolicLinksSync();

  @override
  Future setLastAccessed(DateTime time) {
    throw readOnlyException;
  }

  @override
  void setLastAccessedSync(DateTime time) {
    throw readOnlyException;
  }

  @override
  Future setLastModified(DateTime time) {
    throw readOnlyException;
  }

  @override
  void setLastModifiedSync(DateTime time) {
    throw readOnlyException;
  }

  @override
  FileStat statSync();

  @override
  Uri get uri;

  @override
  Stream<FileSystemEvent> watch(
      {int events = FileSystemEvent.all, bool recursive = false});

  @override
  Future<File> writeAsBytes(List<int> bytes,
      {FileMode mode = FileMode.write, bool flush = false}) {
    throw readOnlyException;
  }

  @override
  void writeAsBytesSync(List<int> bytes,
      {FileMode mode = FileMode.write, bool flush = false}) {
    throw readOnlyException;
  }

  @override
  Future<File> writeAsString(String contents,
      {FileMode mode = FileMode.write,
      Encoding encoding = utf8,
      bool flush = false}) {
    throw readOnlyException;
  }

  @override
  void writeAsStringSync(String contents,
      {FileMode mode = FileMode.write,
      Encoding encoding = utf8,
      bool flush = false}) {
    throw readOnlyException;
  }
}

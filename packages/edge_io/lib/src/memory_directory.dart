import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:path/path.dart' as p;

import 'package:edge_io/file_system_platform_interface.dart';
import 'memory_fse.dart';

final r = Random.secure();
final chars = 'abcdefghijklmnopqrstuvwxyz0123456789'.split('');

String randomString(int length) {
  final b = Uint8List(length);

  for (var i = 0; i < length; i++) {
    b[i] = chars[r.nextInt(chars.length)].codeUnitAt(0);
  }

  return String.fromCharCodes(b);
}

class MemoryDirectory extends MemoryFSE<Directory> implements Directory {
  MemoryDirectory(FileSystemPlatform fs, String path)
      : super(fs, path, FileSystemEntityType.directory);

  @override
  int get size => 4;

  @override
  Future<Directory> create({bool recursive = false}) async {
    return fs.create<MemoryDirectory>(path, this, recursive: recursive);
  }

  @override
  Directory ctor(String path) {
    return MemoryDirectory(fs, path);
  }

  @override
  void createSync({bool recursive = false}) {
    fs.create(path, this, recursive: recursive);
  }

  @override
  Future<Directory> createTemp([String? prefix]) async {
    return createTempSync(prefix);
  }

  @override
  Directory createTempSync([String? prefix]) {
    final tmpPath = p.join(path, '${prefix ?? ''}${randomString(6)}');
    final tmpDir = MemoryDirectory(fs, path);

    return fs.create(tmpPath, tmpDir, recursive: true);
  }

  @override
  Stream<MemoryFSE> list({
    bool recursive = false,
    bool followLinks = true,
  }) {
    final iterable = fs.list<MemoryFSE>(
      path,
      recursive: recursive,
      followLinks: followLinks,
    );

    return Stream.fromIterable(iterable);
  }

  @override
  List<MemoryFSE> listSync({
    bool recursive = false,
    bool followLinks = true,
  }) {
    return fs
        .list<MemoryFSE>(
          path,
          recursive: recursive,
          followLinks: followLinks,
        )
        .toList();
  }
}

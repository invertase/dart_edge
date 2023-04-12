import 'dart:io';

import 'memory_fse.dart';

class MemoryStat implements FileStat {
  final MemoryFSE entity;

  @override
  late DateTime accessed;
  @override
  late DateTime changed;
  @override
  late DateTime modified;

  MemoryStat(
    this.entity, {
    DateTime? accessed,
    DateTime? changed,
    DateTime? modified,
  }) {
    final now = DateTime.now();
    accessed = now;
    changed = now;
    modified = now;
  }

  @override
  int get mode => throw UnimplementedError();

  @override
  String modeString() {
    var permissions = mode & 0xFFF;
    var codes = const ['---', '--x', '-w-', '-wx', 'r--', 'r-x', 'rw-', 'rwx'];
    var result = [];
    if ((permissions & 0x800) != 0) result.add("(suid) ");
    if ((permissions & 0x400) != 0) result.add("(guid) ");
    if ((permissions & 0x200) != 0) result.add("(sticky) ");
    result
      ..add(codes[(permissions >> 6) & 0x7])
      ..add(codes[(permissions >> 3) & 0x7])
      ..add(codes[permissions & 0x7]);
    return result.join();
  }

  @override
  int get size => entity.size;

  @override
  FileSystemEntityType get type => entity.type;
}

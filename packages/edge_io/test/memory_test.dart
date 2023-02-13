import 'dart:io';

import 'package:test/test.dart';
import 'package:edge_io/edge_io.dart' show MemoryFsOverrides;

void main() {
  IOOverrides.global = MemoryFsOverrides();

  group('MemoryFsOverrides', () {
    test('it copies a file to another location', () {
      final file1 = File('file1.txt');

      file1.writeAsStringSync('foo');
      file1.copySync('file2.txt');

      expect(File('file2.txt').readAsStringSync(), 'foo');
    });
  });
}

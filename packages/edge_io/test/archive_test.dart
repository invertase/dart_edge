import 'dart:io';

import 'package:archive/archive_io.dart' as a;
import 'package:test/test.dart';
import 'package:edge_io/archive.dart';

set archive(a.Archive archive) {
  IOOverrides.global = ArchiveFsOverrides.fromArchive(archive);
}

void main() {
  tearDown(() {
    IOOverrides.global = null;
  });

  group('Archive', () {
    group('ArchiveFsOverrides', () {
      test('it mounts to a different path', () {
        final mounted = a.Archive()
          ..addFile(a.ArchiveFile.string('baz.txt', 'baz'));

        IOOverrides.global =
            ArchiveFsOverrides.fromArchive(mounted, mountTo: 'foo/bar');

        expect(File('/foo/bar/baz.txt').readAsStringSync(), 'baz');
      });
    });

    group('File', () {
      group('read', () {
        test('it reads a file', () {
          archive = a.Archive()
            ..addFile(a.ArchiveFile.string('foo.txt', 'foo'));
          final file1 = File('foo.txt');
          final file2 = File('/foo.txt');
          expect(file1.readAsStringSync(), 'foo');
          expect(file2.readAsStringSync(), 'foo');
        });

        test('it throws if the file does not exist', () {
          archive = a.Archive();
          expect(() => File('foo.txt').readAsStringSync(),
              throwsA(isA<FileSystemException>()));
        });
      });
    });

    group('Directory', () {
      group('exists', () {
        test('returns the correct boolean value', () {
          archive = a.Archive()
            ..addFile(a.ArchiveFile.string('foo.txt', 'foo'))
            ..addFile(a.ArchiveFile.string('bar/baz.txt', 'baz'));

          final dir1 = Directory('/');
          final dir2 = Directory('bar');
          final dir3 = Directory('ben');

          expect(dir1.existsSync(), isTrue);
          expect(dir2.existsSync(), isTrue);
          expect(dir3.existsSync(), isFalse);
        });
      });
    });
  });
}

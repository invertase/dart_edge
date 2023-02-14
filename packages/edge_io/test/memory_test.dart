import 'dart:io';

import 'package:test/test.dart';
import 'package:edge_io/edge_io.dart' show MemoryFsOverrides;

void main() {
  final overrides = MemoryFsOverrides();
  IOOverrides.global = overrides;

  setUp(() {
    overrides.clear();
  });

  group('MemoryFsOverrides', () {
    group('File', () {
      group('rename', () {
        test('it renames a file and removes the original', () {
          final file1 = File('file1.txt');

          file1.writeAsStringSync('foo');
          final renamed = file1.renameSync('file2.txt');

          expect(renamed.path, 'file2.txt');
          expect(renamed.readAsStringSync(), 'foo');
          expect(file1.existsSync(), false);
        });

        test('it errors when renaming if the file does not exist', () {
          final file1 = File('file1.txt');

          expect(
            () => file1.renameSync('foo.txt'),
            throwsA(TypeMatcher<PathNotFoundException>()),
          );
        });
      });

      group('copy', () {
        test('it copies a file to another location', () {
          final file1 = File('file1.txt');

          file1.writeAsStringSync('foo');
          final copy = file1.copySync('file2.txt');

          expect(copy.path, 'file2.txt');
          expect(copy.readAsStringSync(), 'foo');
          expect(file1.existsSync(), true);
        });

        test('it errors when copying if the file does not exist', () {
          final file1 = File('file1.txt');

          expect(
            () => file1.copySync('foo.txt'),
            throwsA(TypeMatcher<PathNotFoundException>()),
          );
        });
      });

      group('lastAccessed', () {
        test('it gets the last accessed time', () {
          final file1 = File('file1.txt');
          file1.createSync();
          expect(file1.lastAccessedSync(), isA<DateTime>());
        });

        test(
            'it should throw if last accessed time is called but no file exists',
            () {
          final file1 = File('file1.txt');

          expect(
            () => file1.lastAccessedSync(),
            throwsA(TypeMatcher<PathNotFoundException>()),
          );
        });

        test('it should set last active time', () {
          final file1 = File('file1.txt');
          file1.createSync();
          final time = DateTime.now().subtract(Duration(days: 1));
          file1.setLastAccessedSync(time);
          expect(file1.lastAccessedSync(), time);
        });

        test(
            'it should throw if set last active time is set but no file exists',
            () {
          expect(
            () => File('file1.txt').setLastAccessedSync(DateTime.now()),
            throwsA(TypeMatcher<FileSystemException>()),
          );
        });

        test(
            'it should throw if last accessed time is called but no file exists',
            () {
          final file1 = File('file1.txt');

          expect(
            () => file1.lastAccessedSync(),
            throwsA(TypeMatcher<PathNotFoundException>()),
          );
        });
      });

      group('lastModified', () {
        test('it gets the last modified time', () {
          final file1 = File('file1.txt');
          file1.createSync();
          expect(file1.lastModifiedSync(), isA<DateTime>());
        });

        test(
            'it should throw if last modified time is called but no file exists',
            () {
          final file1 = File('file1.txt');

          expect(
            () => file1.lastModifiedSync(),
            throwsA(TypeMatcher<PathNotFoundException>()),
          );
        });

        test('it should set last modified time', () {
          final file1 = File('file1.txt');
          file1.createSync();
          final time = DateTime.now().subtract(Duration(days: 1));
          file1.setLastModifiedSync(time);
          expect(file1.lastModifiedSync(), time);
        });

        test(
            'it should throw if set last modified time is set but no file exists',
            () {
          expect(
            () => File('file1.txt').setLastModifiedSync(DateTime.now()),
            throwsA(TypeMatcher<FileSystemException>()),
          );
        });

        test(
            'it should throw if last modified time is called but no file exists',
            () {
          final file1 = File('file1.txt');

          expect(
            () => file1.lastModifiedSync(),
            throwsA(TypeMatcher<PathNotFoundException>()),
          );
        });
      });
    });
  });
}

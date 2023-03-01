import 'dart:io';

import 'package:test/test.dart';
import 'package:edge_io/memory.dart';

void main() {
  setUp(() {
    IOOverrides.global = MemoryFsOverrides();
  });

  group('Memory', () {
    group('MemoryFsOverrides', () {
      test('it resolves files and directories to the base bath', () {
        IOOverrides.global = MemoryFsOverrides(
          mountTo: '/foo/bar',
        );

        final file1 = File('file.txt');
        final dir1 = Directory('dir');

        expect(file1.path, 'file.txt');
        expect(dir1.path, 'dir');
        expect(file1.absolute.path, '/foo/bar/file.txt');
        expect(dir1.absolute.path, '/foo/bar/dir');

        final file2 = File('baz/file.txt');
        final dir2 = Directory('baz/dir');

        expect(file2.path, 'baz/file.txt');
        expect(dir2.path, 'baz/dir');
        expect(file2.absolute.path, '/foo/bar/baz/file.txt');
        expect(dir2.absolute.path, '/foo/bar/baz/dir');
      });
    });

    group('File', () {
      group('rename', () {
        test('it renames a file and removes the original', () {
          final file1 = File('file1.txt');
          file1.createSync();
          file1.writeAsStringSync('foo');

          final renamed = file1.renameSync('file2.txt');
          expect(renamed.path, 'file2.txt');
          expect(renamed.readAsStringSync(), 'foo');
          expect(file1.existsSync(), isFalse);
        });

        test('it errors when renaming if the file does not exist', () {
          final file1 = File('file1.txt');

          expect(
            () => file1.renameSync('foo.txt'),
            throwsA(TypeMatcher<PathNotFoundException>()),
          );
        });

        test('it errors when renaming if the file path is a directory', () {
          final dir1 = Directory('dir1');
          dir1.createSync();
          final file1 = File(dir1.path);

          expect(
            () => file1.renameSync('foo.txt'),
            throwsA(TypeMatcher<FileSystemException>()),
          );
        });
      });

      group('exists', () {
        test('it returns a correct boolean value', () {
          final file1 = File('file1.txt');
          final file2 = File('file2.txt');
          expect(file1.existsSync(), isFalse);
          expect(file2.existsSync(), isFalse);

          file1.createSync();

          expect(file1.existsSync(), isTrue);
          expect(file2.existsSync(), isFalse);
        });

        test('it returns false for non-file nodes', () {
          final dir1 = Directory('dir1');
          dir1.createSync();
          final file1 = File(dir1.path);
          expect(file1.existsSync(), isFalse);
        });
      });

      group('copy', () {
        test('it copies a file to another location', () {
          final file1 = File('file1.txt');

          file1.writeAsStringSync('foo');
          final copy = file1.copySync('file2.txt');

          expect(copy.path, 'file2.txt');
          expect(copy.readAsStringSync(), 'foo');
          expect(file1.existsSync(), isTrue);
        });

        test('it errors when copying if the path is not a file node', () {
          final file1 = File('file1.txt');
          final dir1 = Directory('dir');
          dir1.createSync();
          final file2 = File(dir1.path);

          expect(
            () => file1.copySync('foo.txt'),
            throwsA(TypeMatcher<PathNotFoundException>()),
          );

          expect(
            () => file2.copySync('foo.txt'),
            throwsA(TypeMatcher<FileSystemException>()),
          );
        });
      });

      group('create', () {
        test('it creates a file', () {
          final file1 = File('file1.txt');
          expect(file1.existsSync(), isFalse);
          file1.createSync();
          expect(file1.existsSync(), isTrue);
        });

        test('it errors if there is no parent directory', () {
          final file1 = File('foo/bar/file1.txt');
          expect(file1.existsSync(), isFalse);
          expect(
            () => file1.createSync(),
            throwsA(TypeMatcher<FileSystemException>()),
          );
        });

        test('it creates a file recursively', () {
          final file1 = File('foo/bar/file1.txt');
          expect(file1.existsSync(), isFalse);

          file1.createSync(recursive: true);
          expect(Directory('foo').existsSync(), isTrue);
          expect(Directory('foo/bar').existsSync(), isTrue);
          expect(file1.existsSync(), isTrue);
        });

        test('it creates a file, even if one already exists', () {
          final file1 = File('file1.txt');
          expect(file1.existsSync(), isFalse);

          file1.createSync();
          expect(file1.existsSync(), isTrue);

          file1.createSync();
          expect(file1.existsSync(), isTrue);
        });

        test(
            'it throws if creating a file which already exists, while exclusive is enabled',
            () {
          final file1 = File('file1.txt');
          expect(file1.existsSync(), isFalse);

          file1.createSync();
          expect(file1.existsSync(), isTrue);

          expect(
            () => file1.createSync(exclusive: true),
            throwsA(TypeMatcher<FileSystemException>()),
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

      group('length', () {
        test('it gets the length of the file', () {
          final file1 = File('file1.txt');
          file1.writeAsBytesSync([1, 2, 3]);
          expect(file1.lengthSync(), 3);
        });

        test('it errors if the file does not exist', () {
          final file1 = File('file1.txt');

          expect(
            () => file1.lengthSync(),
            throwsA(TypeMatcher<PathNotFoundException>()),
          );
        });
      });

      group('openRead', () {
        test('it opens a file for reading', () {
          final file1 = File('file1.txt');
          file1.writeAsBytesSync([1, 2, 3]);
          final stream = file1.openRead();
          expect(
            stream,
            emitsInOrder([
              [1, 2, 3],
              emitsDone
            ]),
          );
        });

        test('it opens a read with offsets', () {
          final file1 = File('file1.txt');
          file1.writeAsBytesSync([1, 2, 3, 4, 5, 6]);
          final stream = file1.openRead(1, 4);
          expect(
            stream,
            emitsInOrder([
              [
                2,
                3,
                4,
              ],
              emitsDone
            ]),
          );
        });
      });

      group('writeAsBytes', () {
        test('it creates & writes to the filesystem', () {
          final file1 = File('file1.txt');
          file1.writeAsBytesSync([1, 2, 3]);
          expect(file1.readAsBytesSync(), [1, 2, 3]);
        });

        test('it writes to an existing file', () {
          final file1 = File('file1.txt');
          file1.createSync();
          file1.writeAsBytesSync([1, 2, 3]);
          expect(file1.readAsBytesSync(), [1, 2, 3]);
        });

        test('it overwrites a file', () {
          final file1 = File('file1.txt');
          file1.writeAsBytesSync([1, 2, 3]);
          file1.writeAsBytesSync([4, 5, 6]);
          expect(file1.readAsBytesSync(), [4, 5, 6]);
        });

        test('it appends to an existing file', () {
          final file1 = File('file1.txt');
          file1.writeAsBytesSync([1, 2, 3]);
          file1.writeAsBytesSync([4, 5, 6], mode: FileMode.append);
          expect(file1.readAsBytesSync(), [1, 2, 3, 4, 5, 6]);
        });

        test('it throws in read mode', () {
          final file1 = File('file1.txt');
          expect(() => file1.writeAsBytesSync([1, 2, 3], mode: FileMode.read),
              throwsA(isA<FileSystemException>()));
        });
      });
    });

    group('FileStat', () {
      test('it resolves with a file/directory which does not exist', () {
        final stat = File('file1.txt').statSync();
        expect(stat.accessed.millisecondsSinceEpoch, 0);
        expect(stat.modified.millisecondsSinceEpoch, 0);
        expect(stat.changed.millisecondsSinceEpoch, 0);
        expect(stat.mode, 777);
        expect(stat.modeString(), '---------');
        expect(stat.size, -1);
        expect(stat.type, FileSystemEntityType.notFound);
      });

      test('it resolves a valid file', () {
        final file1 = File('file1.txt');
        file1.writeAsBytesSync([1, 2, 3]);
        final stat = file1.statSync();

        expect(stat.accessed.millisecondsSinceEpoch > 0, isTrue);
        expect(stat.modified.millisecondsSinceEpoch > 0, isTrue);
        expect(stat.changed.millisecondsSinceEpoch > 0, isTrue);
        expect(stat.mode, 777);
        expect(stat.modeString().isNotEmpty, isTrue); // TODO: test this better
        expect(stat.size, 3);
        expect(stat.type, FileSystemEntityType.file);
      });

      test('it resolves a valid directory', () {
        final dir1 = Directory('dir1');
        dir1.createSync();

        final dir2 = Directory('${dir1.path}/dir2');
        dir2.createSync();

        File('${dir1.path}/file1.txt').writeAsBytesSync([1, 2, 3]);
        File('${dir1.path}/file2.txt').writeAsBytesSync([3, 4, 5]);
        File('${dir2.path}/file3.txt').writeAsBytesSync([1, 2, 3]);
        File('${dir2.path}/file4.txt').writeAsBytesSync([3, 4, 5]);

        final stat = dir1.statSync();

        expect(stat.accessed.millisecondsSinceEpoch > 0, isTrue);
        expect(stat.modified.millisecondsSinceEpoch > 0, isTrue);
        expect(stat.changed.millisecondsSinceEpoch > 0, isTrue);
        expect(stat.mode, 777);
        expect(stat.modeString().isNotEmpty, isTrue); // TODO: test this better
        expect(stat.size, 12);
        expect(stat.type, FileSystemEntityType.directory);
      });
    });

    group('Directory', () {
      group('rename', () {
        test('it renames a directory and removes the original', () {
          final dir1 = Directory('dir1');

          dir1.createSync();
          final renamed = dir1.renameSync('dir2');

          expect(renamed.path, 'dir2');
          expect(dir1.existsSync(), isFalse);
        });

        test('it errors when renaming if the directory does not exist', () {
          final dir1 = Directory('foo');

          expect(
            () => dir1.renameSync('bar'),
            throwsA(TypeMatcher<PathNotFoundException>()),
          );
        });
      });

      group('exists', () {
        test('it returns a correct boolean value', () {
          final dir1 = Directory('dir1');
          expect(dir1.existsSync(), isFalse);
          dir1.createSync();
          expect(dir1.existsSync(), isTrue);
        });

        test('it returns false for non-directory nodes', () {
          final file1 = File('file1');
          file1.createSync();
          final dir1 = Directory(file1.path);
          expect(dir1.existsSync(), isFalse);
        });
      });

      group('create', () {
        test('it creates a directory', () {
          final dir1 = Directory('dir1');
          expect(dir1.existsSync(), isFalse);
          dir1.createSync();
          expect(dir1.existsSync(), isTrue);
        });

        test('it errors if there is no parent directory', () {
          final dir1 = Directory('foo/bar');
          expect(dir1.existsSync(), isFalse);
          expect(
            () => dir1.createSync(),
            throwsA(TypeMatcher<FileSystemException>()),
          );
        });

        test('it creates a directory recursively', () {
          final dir1 = Directory('foo/bar/baz');
          expect(dir1.existsSync(), isFalse);

          dir1.createSync(recursive: true);
          expect(Directory('foo').existsSync(), isTrue);
          expect(Directory('foo/bar').existsSync(), isTrue);
          expect(dir1.existsSync(), isTrue);
        });

        test('it creates a directory, even if one already exists', () {
          final dir1 = Directory('foo');
          expect(dir1.existsSync(), isFalse);

          dir1.createSync();
          expect(dir1.existsSync(), isTrue);

          dir1.createSync();
          expect(dir1.existsSync(), isTrue);
        });
      });

      group('list', () {
        test('it throws if the directory does not exist', () {
          final dir1 = Directory('foo');
          expect(dir1.existsSync(), isFalse);
          expect(
            () => dir1.listSync(),
            throwsA(TypeMatcher<PathNotFoundException>()),
          );
        });

        test('it returns an empty list for an empty directory', () {
          final dir1 = Directory('foo');
          dir1.createSync();
          expect(dir1.listSync(), isEmpty);
        });

        test('it lists non-recursively', () {
          final dir1 = Directory('foo');
          dir1.createSync();
          File('${dir1.path}/file1.txt').createSync();
          File('${dir1.path}/file2.txt').createSync();
          File('${dir1.path}/file3.txt').createSync();
          Directory('${dir1.path}/dir1').createSync();

          final res = dir1.listSync();

          expect(res, hasLength(4));
          expect(
            res,
            containsAll([
              isA<MemoryFile>(),
              isA<MemoryFile>(),
              isA<MemoryFile>(),
              isA<MemoryDirectory>(),
            ]),
          );
        });

        test('it lists recursively', () {
          final dir1 = Directory('foo');
          dir1.createSync();
          File('${dir1.path}/file1.txt').createSync();
          File('${dir1.path}/file2.txt').createSync();
          File('${dir1.path}/file3.txt').createSync();
          final dir2 = Directory('${dir1.path}/dir1')..createSync();
          File('${dir2.path}/file4.txt').createSync();

          final res = dir1.listSync(recursive: true);

          expect(res, hasLength(5));
          expect(
            res,
            containsAll([
              isA<MemoryFile>(),
              isA<MemoryFile>(),
              isA<MemoryFile>(),
              isA<MemoryDirectory>(),
              isA<MemoryFile>(),
            ]),
          );
        });
      });
    });
  });
}

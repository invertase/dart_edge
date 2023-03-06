import 'package:edge_io/src/file_systems/map_based/map_based_file_system.dart';
import 'package:test/test.dart';

void main() {
  group('MapBasedFileSystem', () {
    test('it mounts with an empty filesystem', () {
      final fs = MapBasedFileSystem('/');
      expect(fs.toMap().keys, hasLength(1));
      expect(fs.toMap()['/'], isA<MapBasedFsDirectoryImplementation>());
    });

    test('it mounts with a base mount', () {
      final fs = MapBasedFileSystem('/foo/bar/baz');
      expect(fs.toMap().keys, hasLength(4));
      expect(fs.toMap()['/'], isA<MapBasedFsDirectoryImplementation>());
      expect(fs.toMap()['/foo'], isA<MapBasedFsDirectoryImplementation>());
      expect(fs.toMap()['/foo/bar'], isA<MapBasedFsDirectoryImplementation>());
      expect(
          fs.toMap()['/foo/bar/baz'], isA<MapBasedFsDirectoryImplementation>());
    });

    test('it clears the file system', () {
      final fs = MapBasedFileSystem('/');
      fs.setRecursively('/foo/bar/baz', MapBasedFsDirectoryImplementation());
      expect(fs.toMap().keys, hasLength(4));
      fs.clear();
      expect(fs.toMap().keys, hasLength(1));
      expect(fs.toMap()['/'], isA<MapBasedFsDirectoryImplementation>());
    });

    test('it clears the file system but remounts the base path', () {
      final fs = MapBasedFileSystem('/foo');
      expect(fs.toMap().keys, hasLength(2));
      fs.clear();
      expect(fs.toMap().keys, hasLength(2));
      expect(fs.toMap()['/'], isA<MapBasedFsDirectoryImplementation>());
      expect(fs.toMap()['/foo'], isA<MapBasedFsDirectoryImplementation>());
    });

    test('it resolves a path', () {
      final fs = MapBasedFileSystem('/foo');
      expect(fs.resolve('/bar'), '/foo/bar');
      expect(fs.resolve('bar'), '/foo/bar');
      expect(fs.resolve('bar/baz'), '/foo/bar/baz');
      expect(fs.resolve('/bar/baz'), '/foo/bar/baz');
    });

    test('it removes a node', () {
      final fs = MapBasedFileSystem('/');
      fs.set('/foo', MapBasedFsFileImplementation());
      expect(fs.toMap().keys, hasLength(2));
      fs.remove('/foo');
      expect(fs.toMap().keys, hasLength(1));
    });

    test('it sets a node', () {
      final fs = MapBasedFileSystem('/');
      fs.set('/foo', MapBasedFsFileImplementation());
      expect(fs.toMap().keys, hasLength(2));
    });

    test('it sets a node recursively', () {
      final fs = MapBasedFileSystem('/');
      fs.setRecursively('/foo/bar/baz', MapBasedFsFileImplementation());
      expect(fs.toMap().keys, hasLength(4));
      expect(fs.toMap()['/'], isA<MapBasedFsDirectoryImplementation>());
      expect(fs.toMap()['/foo'], isA<MapBasedFsDirectoryImplementation>());
      expect(fs.toMap()['/foo/bar'], isA<MapBasedFsDirectoryImplementation>());
      expect(fs.toMap()['/foo/bar/baz'], isA<MapBasedFsFileImplementation>());
    });

    test('it gets a node', () {
      final fs = MapBasedFileSystem('/');
      fs.set('/foo', MapBasedFsFileImplementation());
      fs.set('/bar', MapBasedFsDirectoryImplementation());
      expect(fs.get('/foo'), isA<MapBasedFsFileImplementation>());
      expect(fs.get('/bar'), isA<MapBasedFsDirectoryImplementation>());
    });

    test('it returns null if the node does not exist', () {
      final fs = MapBasedFileSystem('/');
      expect(fs.get('/foo'), isNull);
    });

    test('it returns null if the node is the wrong type', () {
      final fs = MapBasedFileSystem('/');
      fs.set('/foo', MapBasedFsFileImplementation());
      expect(fs.get<MapBasedFsDirectoryImplementation>('/foo'), isNull);
    });
  });
}

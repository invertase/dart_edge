library edge_io.archive;

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:edge_io/src/file_systems/map_based/map_based_file_system.dart';
import 'package:edge_io/src/streamed_stdout.dart';
import 'package:path/path.dart' as p;
import 'package:archive/archive_io.dart' as archive_io;
import 'package:edge_io/src/interfaces/read_only/directory.dart';
import 'package:edge_io/src/interfaces/read_only/entity.dart';
import 'package:edge_io/src/interfaces/read_only/file.dart';
import 'package:edge_io/src/interfaces/read_only/read_only_filesystem.dart';

import 'impl/file_impl.dart';

part 'entity.dart';
part 'directory.dart';
part 'file.dart';

class ArchiveFsOverrides extends ReadOnlyFileSystem {
  /// The archive file.
  final archive_io.Archive _archive;

  final MapBasedFileSystem _fs;

  final Stdout _stdout;

  factory ArchiveFsOverrides.fromFile(File archive, {String mountTo = ""}) {
    if (archive.existsSync()) {
      throw ArgumentError.value(
        archive,
        "archive",
        "Must be a file which exists on the filesystem.",
      );
    }

    return ArchiveFsOverrides._(
      archive: archive_io.ZipDecoder().decodeBytes(archive.readAsBytesSync()),
      mountTo: mountTo,
    );
  }

  factory ArchiveFsOverrides.fromArchive(archive_io.Archive archive,
      {String mountTo = ""}) {
    return ArchiveFsOverrides._(
      archive: archive,
      mountTo: mountTo,
    );
  }

  factory ArchiveFsOverrides.fromBytes(Uint8List bytes, {String mountTo = ""}) {
    return ArchiveFsOverrides._(
      archive: archive_io.ZipDecoder().decodeBytes(bytes),
      mountTo: mountTo,
    );
  }

  /// Creates a new [ArchiveFsOverrides] instance, using a provided [archive].
  ArchiveFsOverrides._({
    required archive_io.Archive archive,
    String mountTo = "",
    Stdout? stdout,
  })  : _fs = MapBasedFileSystem(mountTo),
        _stdout = stdout ?? StreamedStdout(),
        _archive = archive {
    // Mount the archive files to the file system.
    for (final file in _archive.files) {
      if (file.isFile) {
        _fs.setRecursively(file.name, ArchiveFileImplementation(file));
      }
    }
  }

  @override
  ReadOnlyDirectory createDirectory(String path) {
    return ArchiveDirectory._(_fs, path);
  }

  @override
  ReadOnlyFile createFile(String path) {
    return ArchiveFile._(_fs, path);
  }

  @override
  Link createLink(String path) {
    throw UnimplementedError('ArchiveFsOverrides.createLink');
  }

  @override
  Stream<FileSystemEvent> fsWatch(String path, int events, bool recursive) {
    throw UnimplementedError('ArchiveFsOverrides.fsWatch');
  }

  @override
  bool fsWatchIsSupported() {
    return false;
  }

  @override
  Future<FileSystemEntityType> fseGetType(String path, bool followLinks) {
    return Future.value(fseGetTypeSync(path, followLinks));
  }

  @override
  FileSystemEntityType fseGetTypeSync(String path, bool followLinks) {
    throw UnimplementedError('ArchiveFsOverrides.fseGetTypeSync');
  }

  @override
  Future<bool> fseIdentical(String path1, String path2) {
    return Future.value(fseIdenticalSync(path1, path2));
  }

  @override
  bool fseIdenticalSync(String path1, String path2) {
    // TODO(ehesp): This is lazy
    return path1 == path2;
  }

  @override
  Directory getCurrentDirectory() {
    return ArchiveDirectory._(_fs, '/');
  }

  @override
  Future<FileStat> stat(String path) {
    return Future.value(statSync(path));
  }

  @override
  FileStat statSync(String path) {
    throw UnimplementedError('ArchiveFsOverrides.statSync');
  }

  @override
  Stdout get stderr => _stdout;

  @override
  Stdin get stdin => throw UnimplementedError('ArchiveFsOverrides.stdin');

  @override
  Stdout get stdout => _stdout;
}

import 'interop/deno_interop.dart' as interop;

/// Information about a directory entry.
///
/// See https://deno.land/api@v1.30.3?s=Deno.DirEntry
class DirEntry {
  final interop.DirEntry _delegate;

  DirEntry._(this._delegate);

  /// The file name of the entry. It is just the entity name and does not
  /// include the full path.
  String get name => _delegate.name;

  /// True if this is info for a regular file. Mutually exclusive to
  /// DirEntry.isDirectory and DirEntry.isSymlink.
  bool get isFile => _delegate.isFile;

  /// True if this is info for a regular directory. Mutually exclusive to
  /// DirEntry.isFile and DirEntry.isSymlink.
  bool get isDirectory => _delegate.isDirectory;

  /// True if this is info for a symlink. Mutually exclusive to DirEntry.isFile
  /// and DirEntry.isDirectory.
  bool get isSymlink => _delegate.isSymlink;
}

DirEntry dirEntryFromJsObject(interop.DirEntry jsObject) =>
    DirEntry._(jsObject);

class FileInfo {
  final interop.FileInfo _delegate;

  FileInfo._(this._delegate);

  /// True if this is info for a regular file. Mutually exclusive to
  /// FileInfo.isDirectory and FileInfo.isSymlink.
  bool get isFile => _delegate.isFile;

  /// True if this is info for a regular directory. Mutually exclusive to FileInfo.isFile and FileInfo.isSymlink.
  bool get isDirectory => _delegate.isDirectory;

  /// True if this is info for a symlink. Mutually exclusive to FileInfo.isFile and FileInfo.isDirectory.
  bool get isSymlink => _delegate.isSymlink;

  int get size => _delegate.size;

  DateTime? get mtime => _delegate.mtime;

  DateTime? get atime => _delegate.atime;

  DateTime? get birthtime => _delegate.birthtime;

  int? get dev => _delegate.dev;

  int? get ino => _delegate.ino;

  int? get mode => _delegate.mode;

  int? get nlink => _delegate.nlink;

  int? get uid => _delegate.uid;

  int? get gid => _delegate.gid;

  int? get rdev => _delegate.rdev;

  int? get blksize => _delegate.blksize;

  int? get blocks => _delegate.blocks;
}

FileInfo fileInfoFromJsObject(interop.FileInfo jsObject) =>
    FileInfo._(jsObject);

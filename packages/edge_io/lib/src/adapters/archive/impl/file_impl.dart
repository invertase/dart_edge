import 'dart:typed_data';

import 'package:archive/archive_io.dart' as archive_io;
import 'package:edge_io/src/file_systems/map_based/map_based_file_system.dart';

class ArchiveFileImplementation extends MapBasedFsFileImplementation {
  final archive_io.ArchiveFile _delegate;
  ArchiveFileImplementation(this._delegate);

  String get name => _delegate.name;
  int get lastModTime => _delegate.lastModTime;
  Uint8List get content => _delegate.content as Uint8List;
  bool get isSymbolicLink => _delegate.isSymbolicLink;
  String get nameOfLinkedFile => _delegate.nameOfLinkedFile;
}

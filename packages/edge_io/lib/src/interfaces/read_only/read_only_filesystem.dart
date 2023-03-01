import 'dart:io';

import 'directory.dart';
import 'file.dart';

abstract class ReadOnlyFileSystem extends IOOverrides {
  @override
  ReadOnlyDirectory createDirectory(String path);

  @override
  ReadOnlyFile createFile(String path);
}

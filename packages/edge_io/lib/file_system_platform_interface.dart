import 'dart:io';

abstract class FileSystemPlatform {
  Directory get cwd;
  set cwd(Directory directory);

  bool exists(String path, FileSystemEntityType type);
  T rename<T extends FileSystemEntity>(String path, String newPath);
  T create<T extends FileSystemEntity>(
    String path,
    T entity, {
    bool recursive = false,
  });

  T getEntity<T extends FileSystemEntity>(String path);
  FileStat stat<T extends FileSystemEntity>(T entity);

  Iterable<T> list<T extends FileSystemEntity>(
    String path, {
    bool recursive = false,
    bool followLinks = true,
  });
}

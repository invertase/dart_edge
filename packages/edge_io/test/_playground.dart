import 'dart:io';
import 'package:path/path.dart' as p;

File tempFile(File file) {
  final tmp = Directory.systemTemp.createTempSync();
  return File(p.join(tmp.path, file.path));
}

Directory tempDir(Directory directory) {
  final tmp = Directory.systemTemp.createTempSync();
  return Directory(p.join(tmp.path, directory.path));
}

void main() async {
  // await fileAbsolute();
  // await fileCopy();
  // await fileCreate();
  // await fileMetadata();
  // await fileRead();

  await dirRename();
}

Future fileAbsolute() async {
  final file1 = File('file1.txt');
  print(file1.absolute.path);
}

Future rename() async {
  final file1 = tempFile(File('file1.txt'));
  await file1.create();
  final file2 = await file1.rename('newPath.txt');
  print(file1.path);
  print(file2.path);
}

Future fileCopy() async {
  final file1 = tempFile(File('file1.txt'));
  await file1.create();
  final file2 = await file1.copySync('newPath.txt');
  print(file1.path);
  print(file2.path);
}

Future fileCreate() async {
  final file1 = tempFile(File('foo/file1.txt'));
  await file1.create(recursive: true);
  await file1.create(exclusive: true);
  print(file1.path);
}

Future fileMetadata() async {
  final file1 = tempFile(File('file1.txt'));
  // await file1.create(recursive: true);
  // file1.setLastAccessedSync(DateTime.now());
  file1.setLastModifiedSync(DateTime.now());
  // print(file1.lastAccessedSync());
  print(file1.lastModifiedSync());
  await file1.setLastAccessed(DateTime.now());
  print(file1.path);
}

Future fileRead() async {
  final file1 = tempFile(File('foo/file1.txt'));
  // await file1.create(recursive: true);
  await file1.writeAsString('Hello World');
  print(await file1.readAsString());
}

Future dirRename() async {
  final dir1 = tempDir(Directory('foo'));
  await dir1.create(recursive: true);
  print(dir1.listSync());
  print(dir1.path);
}

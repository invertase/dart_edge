import 'dart:io';
import 'package:path/path.dart' as p;

File tempFile(File file) {
  final tmp = Directory.systemTemp.createTempSync();
  return File(p.join(tmp.path, file.path));
}

void main() async {
  await absolute();
  // await copy();
  // await create();
  // await metadata();
  // await read();
}

Future absolute() async {
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

Future copy() async {
  final file1 = tempFile(File('file1.txt'));
  await file1.create();
  final file2 = await file1.copySync('newPath.txt');
  print(file1.path);
  print(file2.path);
}

Future create() async {
  final file1 = tempFile(File('foo/file1.txt'));
  await file1.create(recursive: true);
  await file1.create(exclusive: true);
  print(file1.path);
}

Future metadata() async {
  final file1 = tempFile(File('file1.txt'));
  // await file1.create(recursive: true);
  // file1.setLastAccessedSync(DateTime.now());
  file1.setLastModifiedSync(DateTime.now());
  // print(file1.lastAccessedSync());
  print(file1.lastModifiedSync());
  await file1.setLastAccessed(DateTime.now());
  print(file1.path);
}

Future read() async {
  final file1 = tempFile(File('foo/file1.txt'));
  // await file1.create(recursive: true);
  await file1.writeAsString('Hello World');
  print(await file1.readAsString());
}

import 'dart:io';

void main() {
  final d = Directory.current;

  print(d.path);

  final temp = d.createTempSync();

  print(temp.absolute.path);
}

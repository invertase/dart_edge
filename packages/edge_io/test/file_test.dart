import 'dart:io';

import 'package:edge_io/edge_io.dart';
import 'package:test/test.dart';

void main() {
  setUpAll(() {
    IOOverrides.global = EdgeIOOverrides();
  });
}

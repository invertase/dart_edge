# Edge IO - Dart Edge

This package (will eventually) contains a set of io adapters for use on Edge environments.

> This package is currently in development and is not yet ready for use.

## Usage

Install the package:

```
dart pub add edge_io
```

Import the adapter you require, e.g. Memory:

```dart
import 'package:edge_io/memory.dart';
```

Override the io adapter:

```dart
import 'dart:io';
import 'package:edge_io/memory.dart';

void main() {
  final overrides = MemoryFsOverrides();
  IOOverrides.global = overrides;

  // Use io as normal, e.g.:
  final file = File('test.txt');
}
```
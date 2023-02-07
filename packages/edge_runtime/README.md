# Dart Edge Runtime

This package provides a Dart runtime for the Edge framework. It can either be used as a standalone
package or part of a platform runtime, such as [`vercel_edge`](https://pub.dev/packages/vercel_edge).

## Usage

A simple usage example:

```dart
import 'package:edge_runtime/edge_runtime.dart';

void main() {
  addFetchEventListener((event) {
    event.respondWith(Response.ok('Hello, world!'));
  });
}
```
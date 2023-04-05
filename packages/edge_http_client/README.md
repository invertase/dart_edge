# Dart Edge Http Client

This package provides a Dart package for using the [`http`](https://pub.dev/packages/http) package in Edge environments.

## Usage

A simple usage example:

```dart
import 'package:edge_http_client/edge_http_client.dart';
import 'package:http/http.dart' as http;

void main() {
  runWithClient(myFunction, () => EdgeHttpClient());
}

Future<void> myFunction() async {
  final response = await http.get(Uri.https('www.example.com', ''));
}
```
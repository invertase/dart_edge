import 'package:v8_runtime/v8_runtime.dart';

Future<Response> fetchFromServer(String path, [RequestInit? init]) {
  return fetch(Resource('http://0.0.0.0:3001$path'), init);
}

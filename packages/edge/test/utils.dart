import 'package:edge/runtime.dart';

Request serverRequest(String path, [RequestInit? init]) {
  return Request(Resource('http://0.0.0.0:3001$path'), init);
}

Future<Response> fetchFromServer(String path, [RequestInit? init]) {
  return fetch(Resource('http://0.0.0.0:3001$path'), init);
}

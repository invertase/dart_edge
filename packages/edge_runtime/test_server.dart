import 'dart:convert';

import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;

void main() async {
  var app = Router();

  app.get('/200', (Request request) {
    return Response.ok('GET');
  });

  app.get('/200/json', (Request request) {
    return Response(
      200,
      body: jsonEncode({
        'foo': 'bar',
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );
  });

  app.get('/200/stream', (Request request) {
    return Response(
      200,
      body: Stream.fromIterable(
        List.generate(100, (index) {
          return List.generate(10 * 1024, (index) => index % 256);
        }),
      ),
      headers: {
        'Content-Type': 'application/octet-stream',
      },
    );
  });

  app.post('/200', (Request request) {
    return Response.ok('POST');
  });

  final handler = const Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware((innerHandler) {
    return (request) async {
      return Future.sync(() => innerHandler(request)).then((response) {
        return response.change(headers: {
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-Methods': '*',
          'Access-Control-Allow-Headers': '*',
        });
      });
    };
  }).addHandler(app);

  final server = await io.serve(handler, '127.0.0.1', 3001);

  print('Serving at http://${server.address.host}:${server.port}');
}

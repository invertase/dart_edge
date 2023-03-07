import 'dart:convert';

import 'package:edge_runtime/edge_runtime.dart';
import 'package:test/test.dart';

void main() {
  final client = HttpClient();

  group('HttpClient', () {
    group('perfroms GET request', () {
      test('without body', () async {
        final Uri uri = Uri.parse('http://localhost:3001/200');
        final req = await client.getUrl(uri);
        final res = await req.close();

        expect(res.statusCode, 200);
      });

      test('with JSON body', () async {
        final Uri uri = Uri.parse('http://localhost:3001/200/json');
        final req = await client.getUrl(uri);
        final res = await req.close();

        expect(res.statusCode, 200);
        expect(await res.transform(utf8.decoder).join(), '{"foo":"bar"}');
      });

      test('supports streaming', () async {
        final Uri uri = Uri.parse('http://localhost:3001/200/stream');
        final req = await client.getUrl(uri);
        final res = await req.close();

        expect(res.statusCode, 200);

        final responseChunks = await res.toList();
        expect(responseChunks.length, greaterThan(1));
      });
    });
  });
}

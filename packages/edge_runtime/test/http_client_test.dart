import 'package:edge_runtime/edge_runtime.dart';
import 'package:http/http.dart' as http;
import 'package:test/test.dart';

Future Function() run(Future Function() fn) {
  return () async {
    await http.runWithClient(fn, () => Client());
  };
}

void main() {
  group('package:http Client', () {
    group('perfroms GET request', () {
      test('without body', run(() async {
        final Uri uri = Uri.parse('http://localhost:3001/200');
        final res = await http.get(uri);

        expect(res.statusCode, 200);
      }));

      test('with JSON body', run(() async {
        final Uri uri = Uri.parse('http://localhost:3001/200/json');
        final res = await http.get(uri);

        expect(res.statusCode, 200);
        expect(res.body, '{"foo":"bar"}');
      }));

      test('supports streaming', run(() async {
        final Uri uri = Uri.parse('http://localhost:3001/200/stream');

        final req = http.Request('GET', uri);
        final res = await req.send();

        expect(res.statusCode, 200);

        final responseChunks = await res.stream.toList();
        expect(responseChunks.length, greaterThan(1));
      }));
    });
  });
}

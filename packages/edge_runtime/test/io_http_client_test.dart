import 'package:edge_runtime/edge_runtime.dart';
import 'package:test/test.dart';

void main() {
  final client = HttpClient();

  group('HttpClient', () {
    test('perfroms GET request', () async {
      final Uri uri = Uri.parse('http://localhost:3001/200');
      final req = await client.getUrl(uri);
      final res = await req.close();

      expect(res.statusCode, 200);
    });
  });
}

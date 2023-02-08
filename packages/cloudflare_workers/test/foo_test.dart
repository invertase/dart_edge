import 'package:test/test.dart';

import 'utils.dart';

void main() {
  test('foo', () async {
    final response = await runOnMiniflare('''
CloudflareWorkers(
  fetch: (request, env, ctx) {
    return Response('Hello!!!');
  },
);
''');

    expect(response.ok, true);
    expect(await response.text(), 'Hello!!!');
  });

  test('bar', () async {
    final response = await runOnMiniflare('''
CloudflareWorkers(
  fetch: (request, env, ctx) async {
    await Future.delayed(Duration(seconds: 1));
    return Response('World!!!');
  },
);
''');

    expect(response.ok, true);
    expect(await response.text(), 'World!!!');
  });
}

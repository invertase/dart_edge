import 'package:test/test.dart';

import 'utils.dart';

void main() {
  test('it returns a valid response', () async {
    final mf = await runOnMiniflare('''
CloudflareWorkers(
  fetch: (request, env, ctx) {
    return Response('foo');
  },
);
''');

    final response = await mf.dispatchFetch();

    expect(response.ok, true);
    expect(await response.text(), 'foo');
  });
}

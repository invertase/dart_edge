import 'package:cloudflare_workers/cloudflare_workers.dart';

void main() {
  CloudflareWorkers(
    fetch: (request, env, ctx) async {
      try {
        final kv = env.getKVNamespace('TEST_KV');
        final res = await kv.getWithMetadata('foo');
        return Response(res.metadata, status: 200);
      } catch (e) {
        return Response(e.toString(), status: 500);
      }
    },
  );
}

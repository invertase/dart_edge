import 'package:cloudflare_workers/cloudflare_workers.dart';

class TestClass extends DurableObject {
  @override
  FutureOr<Response> fetch(Request request) async {
    // These calls are transactional.
    final views = (await state.storage.get<int>('views') ?? 0) + 1;
    await state.storage.put('views', views);

    // Set an alarm to trigger in a few seconds (if not already set).
    if (await state.storage.getAlarm() == null) {
      await state.storage.setAlarm(DateTime.now().add(Duration(seconds: 2)));
    }

    return Response('Path "${request.url.path}" called $views times.');
  }

  @override
  FutureOr<void> alarm() {
    print('Durable Object Alarm Called');
  }
}

void main() {
  CloudflareWorkers(
    durableObjects: {
      'TestClass': () => TestClass(),
    },
    fetch: (request, env, ctx) {
      // Ignore browser favicon requests.
      if (request.url.toString().contains('favicon.ico')) {
        return Response(null);
      }

      // Get the DO namespace (defined in your wrangler.toml)
      final namespace = env.getDurableObjectNamespace('TEST');

      // Get an ID for the DO (this can be based on the request, name, user ID etc)
      final id = namespace.idFromName(request.url.path);

      // Send the DO a request instance.
      return namespace.get(id).fetch(request);
    },
  );
}

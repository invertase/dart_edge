import 'package:cloudflare_workers/cloudflare_workers.dart';

void main() {
  CloudflareWorkers(
    // durableObjects: [ElliotDurableObject('ElliotDurableObject')],
    fetch: (request, env, ctx) {
      if (request.url.toString().contains('favicon.ico')) {
        return Response('favicon.ico');
      }

      return Response('Hello World!!');
    },
    scheduled: (event, env, ctx) {
      // ScheduledEvent!!
    },
  );
}

{{^shelf}}
import 'package:cloudflare_workers/cloudflare_workers.dart';
{{/shelf}}
{{#shelf}}
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf.dart';
import 'package:cloudflare_workers/cloudflare_workers_shelf.dart';
{{/shelf}}

void main() {
  {{^shelf}}
  CloudflareWorkers(fetch: (request, env, ctx) {
    return Response("Hello...");
  });
  {{/shelf}}
  {{#shelf}}
  CloudflareWorkersShelf(fetch: (request, env, ctx) {
    final app = Router();

    app.get('/hello', (request) {
      return Response.ok("World!");
    });

    app.all('/<ignored|.*>', (request) {
      return Response.notFound('Not found');
    });

    return app(request);
  });
  {{/shelf}}
}

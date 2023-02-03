# Dart Edge

Dart Edge is a project aimed at running Dart code on Edge functions, including support for platforms such as [Cloudflare Workers](https://workers.cloudflare.com/) & [Vercel Edge Functions](https://vercel.com/features/edge-functions) (more to come).

```dart
import 'package:vercel_edge/vercel_edge_shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf.dart';

void main() {
  VercelEdgeShelf(
    fetch: (request) async {
      final app = Router();

      app.get('/user/<id>', (request, String id) async {
        return Response.ok('Welcome, $id');
      });

      app.all('/<ignored|.*>', (request) {
        return Response.notFound('Resource not found');
      });

      final handler = const Pipeline().addMiddleware(logRequests()).addHandler(app);
      return handler(request);
    },
  );
}
```

Edge functions are serverless functions which run on Edge networks, providing a number of benefits to server based environmnets (but also carried some limitations). Some of these benefits include:

- ⚡ **Decreased Latency**: Edge functions run close to your users, reducing request latency (rather than running in a region(s)).
- ⏱ **Code Boot Times**: Edge functions have minimal code boot times vs traditional serverless functions.
- ✨ **Platform APIs**: Access powerful platform specific APIs, such as Cloudflare Workers [HTMLRewriter](https://developers.cloudflare.com/workers/runtime-apis/html-rewriter/), [KV](https://developers.cloudflare.com/workers/runtime-apis/kv/),
  [Durable Objects](https://developers.cloudflare.com/workers/runtime-apis/durable-objects/) & more.
- 🌎 **Runtime APIs**: Edge functions run on the [JavaScript V8 runtime](https://developers.google.com/apps-script/guides/v8-runtime), and provides a subset of standard Web APIs to access familar APIs such as Cache, Crypto, Fetch, etc.

This project provides Dart bindings to the Edge runtime APIs, allowing you to write Dart code which can be run on Edge functions. Your code is compiled to JavaScript and deployed to the Edge network (WASM support possible in the future).

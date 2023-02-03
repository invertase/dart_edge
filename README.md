<h1 align="center">Dart Edge (Experimental)</h1>
<p align="center">Run Dart on on the Edge - supporting Vercel & Cloudflare Workers (more coming soon).</p>

<p align="center">
  <a href="https://github.com/invertase/melos#readme-badge"><img src="https://img.shields.io/badge/maintained%20with-melos-f700ff.svg?style=flat-square" alt="Melos" /></a>
  <a href="https://docs.page"><img src="https://img.shields.io/badge/powered%20by-docs.page-34C4AC.svg?style=flat-square" alt="docs.page" /></a>
 <a href="https://invertase.link/discord">
   <img src="https://img.shields.io/discord/295953187817521152.svg?style=flat-square&colorA=7289da&label=Chat%20on%20Discord" alt="Chat on Discord">
 </a>
</p>

<p align="center">
  <a href="https://docs.dartedge.dev/">Documentation</a> &bull;
  <a href="https://github.com/invertase/dart_workers/LICENSE">License</a>
</p>

## About

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

Edge functions are serverless functions which run on Edge networks, providing a number of benefits to server based envirommnets (but also carried some limitations). Some of these benefits include:

- ⚡ **Decreased Latency**: Edge functions run close to your users, reducing request latency (rather than running in a region(s)).
- ⏱ **Code Boot Times**: Edge functions have minimal code boot times vs traditional serverless functions.
- ✨ **Platform APIs**: Access powerful platform specific APIs, such as Cloudflare Workers [HTMLRewriter](https://developers.cloudflare.com/workers/runtime-apis/html-rewriter/), [KV](https://developers.cloudflare.com/workers/runtime-apis/kv/),
  [Durable Objects](https://developers.cloudflare.com/workers/runtime-apis/durable-objects/) & more.
- 🌎 **Runtime APIs**: Edge functions run on the [JavaScript V8 runtime](https://developers.google.com/apps-script/guides/v8-runtime), and provides a subset of standard Web APIs to access familar APIs such as Cache, Crypto, Fetch, etc.

This project provides Dart bindings to the Edge runtime APIs, allowing you to write Dart code which can be run on Edge functions. Your code is compiled to JavaScript and deployed to the Edge network (WASM support possible in the future).

## Supported Platforms

We are working to enable Dart Edge to be deployed to many platforms as possible. Currently we support:

- [Cloudflare Workers](https://workers.cloudflare.com/) - [Documentation](https://docs.dartedge.dev/platform/cloudflare)
- [Vercel Edge Functions](https://vercel.com/features/edge-functions) - [Documentation](https://docs.dartedge.dev/platform/vercel)

> Please see the platform documentation for API status.

Other platforms we'll likely add support for are; [Netlify Edge](https://www.netlify.com/products/edge/), [Deno Deploy](https://deno.com/deploy), [Supabase Functions](https://supabase.com/edge-functions), [AWS Lambda@Edge](https://aws.amazon.com/lambda/edge/). Feel free to reach out if you'd like to see support for a specific platform.

## FAQs

### ❓ Why is it experimental?

This project is a new concept, and we're still figuring out things such as the public APIs, testing, best practices for local development & deployment and other complicated matters such as error handling and debugging (since Dart is compiled to minified JavaScript). We use this project in production ourselves as a dog-fooding excercise, however we'll keep it as experimental until we're happy we've covered all bases of what you'd expect from Dart development.

We will probably be making breaking changes without following semver until we're happy for a major release. So please be aware of this.

There's also some unimplemented APIs which we're working on. Please see the [API](https://docs.dartedge.dev/apis) documentation for more information.

### ❓ What is the motivation for this project?

We're big fans of serverless environments, and are using both [Cloudflare Workers](https://workers.cloudflare.com/) & [Vercel Edge Functions](https://vercel.com/features/edge-functions) on our own projects. Some of these projects (including [Zapp!](https://zapp.run/)) are written in Dart. We wanted to be able to write Dart code and deploy it to these platforms to allow for code sharing & collaboration between the team, hence this project started.

### ❓ What are the limitations of Edge functions?

If you're not familar with the concept of serverless functions, you should be aware of the limitations. Typically to run Dart as a backend service, you will most likely reach for [Shelf](https://github.com/dart-lang/shelf), (or use a framework such as as [ServerPod](https://serverpod.dev/), [Dart Frog](https://dartfrog.vgv.dev/) etc) which are deployed to services such as Google Cloud Run, AWS etc. These setups run your code in a container, running one or more long lived processed to keep your service running. You can access the file system, use a single database connection, establish a long-lived WebSocket connection, etc.

Serverless functions on the Edge are different. They are invoked once-per-request and are not long lived. You cannot access the file system, and in some cases cannot establish long-lived connections (depending on the platform). Netlify
has a great [article](https://www.netlify.com/blog/edge-functions-explained/) explaining the differences.

<hr />

<p align="center">
  <a href="https://invertase.io/?utm_source=readme&utm_medium=footer&utm_campaign=edge">
    <img width="75px" src="https://static.invertase.io/assets/invertase/invertase-rounded-avatar.png">
  </a>
  <p align="center">
    Built and maintained by <a href="https://invertase.io/?utm_source=readme&utm_medium=footer&utm_campaign=edge">Invertase</a>.
  </p>
</p>

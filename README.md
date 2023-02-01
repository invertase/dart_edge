<p align="center">
  <h1>Dart Edge (Experimental)</h1>
  <span>Run Dart on on the Edge.</span>
</p>

<p align="center">
  <a href="https://github.com/invertase/melos#readme-badge"><img src="https://img.shields.io/badge/maintained%20with-melos-f700ff.svg?style=flat-square" alt="Melos" /></a>
  <a href="https://docs.page"><img src="https://img.shields.io/badge/powered%20by-docs.page-34C4AC.svg?style=flat-square" alt="docs.page" /></a>
 <a href="https://invertase.link/discord">
   <img src="https://img.shields.io/discord/295953187817521152.svg?style=flat-square&colorA=7289da&label=Chat%20on%20Discord" alt="Chat on Discord">
 </a>
</p>

<p align="center">
  <a href="#">Documentation</a> &bull;
  <a href="https://github.com/invertase/dart_workers/LICENSE">License</a>
</p>

## About

Dart Edge is a project aimed at running Dart code on Edge functions, including support for platforms such as [Cloudflare Workers](https://workers.cloudflare.com/) & [Vercel Edge Functions](https://vercel.com/features/edge-functions) (more to come). You can write and deploy code in a little as:

```dart
import 'package:vercel_edge/vercel_edge.dart';

void main() {
  VercelEdge(fetch: (request) {
    if (request.url.path == '/users') {
      final users = await fetch('https://example.com/users');
      return Response.json(await users.json());
    }

    return Response('Not Found', ResponseInit(status: 404));
  });
}
```

Edge functions are serverless functions which run on Edge networks, providing a number of benefits to server based envirommnets (but also carried some limitations). Some of these benefits include:

- **Decreased Latency**: Edge functions run close to your users, reducing request latency (rather than running in a region(s)).
- **Code Boot Times**: Edge functions have minimal code boot times vs traditional serverless functions.
- **Platform APIs**: Access powerful platform specific APIs, such as Cloudflare Workers [HTMLRewriter](https://developers.cloudflare.com/workers/runtime-apis/html-rewriter/), [KV](https://developers.cloudflare.com/workers/runtime-apis/kv/),
  [Durable Objects](https://developers.cloudflare.com/workers/runtime-apis/durable-objects/) & more.
- **Runtime APIs**: Edge functions run on the [JavaScript V8 runtime](https://developers.google.com/apps-script/guides/v8-runtime), and provides a subset of standard Web APIs to access familar APIs such as Cache, Crypto, Fetch, etc.

This project provides Dart bindings to the Edge runtime APIs, allowing you to write Dart code which can be run on Edge functions. Your code is compiled to JavaScript and deployed to the Edge network (WASM support possible in the future).

## Supported Platforms

We are working to enable Dart Edge to be deployed to many platforms as possible. Currently we support:

- [Cloudflare Workers](https://workers.cloudflare.com/) - [Documentation](#)
- [Vercel Edge Functions](https://vercel.com/features/edge-functions) - [Documentation](#)

> Please see the platform documentation for API status.

Other platforms we'll likely add support for are; [Netlify Edge](https://www.netlify.com/products/edge/), [Deno Deploy](https://deno.com/deploy), [Supabase Functions](https://supabase.com/edge-functions), [AWS Lambda@Edge](https://aws.amazon.com/lambda/edge/). Feel free to reach out if you'd like to see support for a specific platform.

## FAQs

### Why is it experimental?

This project is a new concept, and we're still figuring out things such as the API, testing, best practices for local development & deployment and other complicated matters such as error handling and debugging (since Dart is compiled to minified JavaScript). We use this project in production ourselves as a dog-fooding excercise, however we'll keep it as experimental until we're happy we've covered all bases of what you'd expect from Dart development.

### What is the motivation for this project?

We are big fans of running serverless code, and are using both [Cloudflare Workers](https://workers.cloudflare.com/) & [Vercel Edge Functions](https://vercel.com/features/edge-functions) on our own projects. Some of these projects (including [Zapp!](https://zapp.run/)) are mainly written in Dart. We wanted to be able to write Dart code and deploy it to these platforms to allow for code sharing & collaboration between the team, hence this project started.

### What are the limitations of Edge functions?

If you're not familar with the concept of serverless functions, you should be aware of the limitations. Typically to run Dart as a backend service, you will most likely reach for [Shelf](https://github.com/dart-lang/shelf), (or use a framework such as as [ServerPod](https://serverpod.dev/), [Dart Frog](https://dartfrog.vgv.dev/) etc) which are deployed to services such as Google Cloud Run, AWS etc. These setups run your code in a container, running one or more long lived processed to keep your service running. You can access the file system, use a single database connection, establish a long-lived WebSocket connection, etc.

Serverless functions on the Edge are different. They are invoked once-per-request and are not long lived. You cannot access the file system, and in some cases cannot establish long-lived connections (depending on the platform). Netlify
has a great [article](https://www.netlify.com/blog/edge-functions-explained/) explaining the differences.

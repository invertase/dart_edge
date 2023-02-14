# Cloudflare Workers - Dart Edge

This package is part of the [Dart Edge](https://dartedge.dev) project, enabling you to write and deploy to [Cloudflare Workers](https://workers.cloudflare.com/) using Dart.

## Getting Started

Install the Cloudflare [`wrangler` CLI](https://developers.cloudflare.com/workers/wrangler/) globally.

Next, install the `edge` package globally.

```bash
pub global activate edge
```

Create a new project:

```bash
edge new cloudflare_workers new_project
```

To learn more, visit the [documentation](https://docs.dartedge.dev).

## Testing

To run the tests, install the Node dependencies:

```bash
npm install
```

Then run the tests:

```bash
dart test -p node
```
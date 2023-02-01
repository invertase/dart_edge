# Cloudflare Durable Objects Example

Durable Objects provide low-latency coordination and consistent storage for the Workers platform through two features: global uniqueness and a transactional storage API.

[Learn more](https://developers.cloudflare.com/workers/learning/using-durable-objects/).

## Running the example

First ensure the [Cloudflare CLI](https://developers.cloudflare.com/workers/wrangler/install-and-update/) is installed:

```sh
npm install -g wrangler
```

Install pub dependencies:

```sh
dart pub get
```

Start the example:

```sh
wrangler dev --local
```

## Using the example

Incoming requests are sent to a Durable Object, which contains a persisted view count. Visit the URL via the
web-server started by wrangler.

Each time you request the page, the view count will be transactionally incremenedt and be persisted within the Durable Object.

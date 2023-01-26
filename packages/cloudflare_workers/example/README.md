# Cloudflare Workers

Add this file to the `.dart_tool/workers/entry.js` directory:

> Temporary workaround until CLI is in place.

```js
// This is a generated file, do not modify.
import "./main.dart.js";

export default {
  async fetch(request, env, ctx) {
    if (self.__dartFetchHandler !== undefined) {
      return self.__dartFetchHandler(request, env, ctx);
    }
  },
  async scheduled(event, env, ctx) {
    if (self.__dartScheduledHandler !== undefined) {
      return self.__dartScheduledHandler(event, env, ctx);
    }
  }
};
```

## Development

To run this example locally:

```bash
wrangler dev --local
```
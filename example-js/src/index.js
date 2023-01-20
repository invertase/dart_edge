/**
 * Welcome to Cloudflare Workers! This is your first worker.
 *
 * - Run `npx wrangler dev src/index.js` in your terminal to start a development server
 * - Open a browser tab at http://localhost:8787/ to see your worker in action
 * - Run `npx wrangler publish src/index.js --name my-worker` to publish your worker
 *
 * Learn more at https://developers.cloudflare.com/workers/
 */

export default {
  async fetch(request) {
    const quotesUrl = "https://dummyjson.com/quotes/random";

    const myCache = await caches.open("my-cache");

    const cachedResponse = await myCache.match(quotesUrl);
    if (cachedResponse) {
      console.log("Returning cached response");
      return cachedResponse;
    }

    const quotesResponse = await fetch(quotesUrl);
    const quotes = await quotesResponse.json();

    const response = Response.json(quotes);
    await myCache.put(quotesUrl, response.clone());

    return response.clone();
  },
};

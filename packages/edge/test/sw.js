let port;

self.addEventListener("activate", function (event) {
  console.log("Claiming control");
  return self.clients.claim();
});

addEventListener("install", function (event) {
  event.waitUntil(self.skipWaiting());
});

addEventListener("fetch", (event) => {
  console.log("fetch event", event);
  if (port) {
    port.postMessage({
      type: "fetch",
      // event: {
      // type: event.type,
      // request: {
      //   url: event.request.url,
      //   method: event.request.method,
      //   headers: [...event.request.headers.entries()],
      //   body: event.request.body,
      //   cache: event.request.cache,
      //   credentials: event.request.credentials,
      //   destination: event.request.destination,
      //   integrity: event.request.integrity,
      //   keepalive: event.request.keepalive,
      //   mode: event.request.mode,
      //   redirect: event.request.redirect,
      //   referrer: event.request.referrer,
      //   referrerPolicy: event.request.referrerPolicy,
      // },
      // },
    });

    event.respondWith(new Response('ok'));
  }
});

addEventListener("message", (event) => {
  console.log("message event", event);
  if (event.data === "init") {
    port = event.ports[0];
    port.postMessage("init");
  }
});

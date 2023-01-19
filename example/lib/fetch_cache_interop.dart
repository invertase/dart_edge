@js.JS('caches')
library cache;

import 'package:js/js.dart' as js;
import 'fetch_interop.dart' show Promise, Response, Request;

// TODO this is Cloudflare specific - move to extension or something?
@js.JS('default')
external Promise<CacheStorage> get defaultCache;

@js.JS('open')
external Promise<CacheStorage> open(String name);

@js.JS()
class CacheStorage {
  external Promise<bool> delete(String cacheName);
  external Promise<bool> has(String cacheName);
  external Promise<List<Object>> keys(String cacheName);
  external Promise<Response?> match(Object resource, [Object? options]);
  external Promise<Cache> open(String cacheName);
}

@js.JS()
class Cache {
  external Promise add(String url);
  external Promise addAll(List<String> urls);
  external Promise delete(String url, [Object? options]);
  external Promise<List<Request>> keys(Object resource, [Object? options]);
  external Promise<Response?> match(Object resource, [Object? options]);
  external Promise<List<Response>> matchAll(Object resource, [Object? options]);
  external Promise put(Request request, Response response);
}

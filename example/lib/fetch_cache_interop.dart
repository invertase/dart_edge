@js.JS('caches')
library cache;

import 'package:js/js.dart' as js;
import 'fetch_interop.dart' show Promise, Response, Request;

// TODO this is Cloudflare specific - move to extension or something?
@js.JS('default')
external Cache get defaultCache;

@js.JS('delete')
external Promise<bool> delete(String cacheName);

@js.JS('has')
external Promise<bool> has(String cacheName);

@js.JS('keys')
external Promise<List<Object>> keys(String cacheName);

@js.JS('match')
external Promise<Response?> match(Object resource, [Object? options]);

@js.JS('open')
external Promise<Cache> open(String cacheName);

@js.JS()
class Cache {
  external Promise add(String url);
  external Promise addAll(List<String> urls);
  external Promise delete(String url, [Object? options]);
  external Promise<List<Object>> keys(String url, [Object? options]);
  external Promise<Object?> match(String url, [Object? options]);
  external Promise<List<Response>> matchAll(Object resource, [Object? options]);
  external Promise put(Request request, Response response);
}

import 'package:js/js.dart' as js;
import 'package:js_bindings/js_bindings.dart' as interop;

export 'cf_cache_interop.dart' show defaultCache;

@js.JS('caches')
external interop.CacheStorage get caches;

@js.JS('caches')
library cache;

import 'package:js/js.dart' as js;
import 'package:js_bindings/js_bindings.dart' as interop;

// TODO this is Cloudflare specific - move to extension or something?
@js.JS('default')
external interop.Cache get defaultCache;

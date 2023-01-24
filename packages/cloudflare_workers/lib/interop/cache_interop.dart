@js.JS('caches')
library cache;

import 'package:js/js.dart' as js;
import 'package:js_bindings/js_bindings.dart' as interop;

@js.JS('default')
external interop.Cache get defaultCache;

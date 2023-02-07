import 'package:edge_runtime/edge_runtime.dart';
import 'package:edge_runtime/src/cache/cache.dart';

import '../interop/cache_interop.dart' as interop;

extension CloudflareWorkersCacheStorageExtension on CacheStorage {
  Cache get defaultCache => cacheFromJsObject(interop.defaultCache);
}

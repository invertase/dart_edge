import 'package:edge/runtime/cache/cache.dart';
import 'package:edge/runtime/cache/cache_storage.dart';

import '../interop/cache_interop.dart' as interop;

extension CloudflareWorkersCacheStorageExtension on CacheStorage {
  Cache get defaultCache => cacheFromJsObject(interop.defaultCache);
}

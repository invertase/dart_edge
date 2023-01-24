import 'package:v8_runtime/v8_runtime.dart';
import 'package:v8_runtime/public/cache.dart';

import '../interop/cache_interop.dart' as interop;

extension CloudflareWorkersCacheStorageExtension on CacheStorage {
  Cache get defaultCache => cacheFromJsObject(interop.defaultCache);
}

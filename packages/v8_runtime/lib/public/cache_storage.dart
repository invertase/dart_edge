import 'dart:js_util';

import 'package:js_bindings/js_bindings.dart' as interop;
import '../interop/cache_interop.dart' as interop;
import 'cache.dart';
import 'request.dart';
import 'response.dart';

final caches = CacheStorage._(interop.caches);

class CacheStorage {
  final interop.CacheStorage _delegate;

  CacheStorage._(this._delegate);

  Future<bool> delete(String cacheName) async {
    return _delegate.delete(cacheName);
  }

  Future<bool> has(String cacheName) async {
    return _delegate.has(cacheName);
  }

  Future<Iterable<String>> keys() async {
    throw UnimplementedError(
        'TODO: delegate API does not return the correct type');
    return _delegate.keys();
  }

  // TODO - support match options.
  // MultiCacheQueryOptions requires a string value (cacheName), but this throws on CF.
  Future<Response?> match(Request request) async {
    final obj = await promiseToFuture<interop.Response?>(
        _delegate.match(request.delegate));
    return obj == null ? null : responseFromJsObject(obj);
  }

  Future<Cache> open(String name) async {
    return cacheFromJsObject(await _delegate.open(name));
  }
}

class CacheQueryOptions {
  bool? ignoreSearch;
  bool? ignoreMethod;
  bool? ignoreVary;

  CacheQueryOptions({
    this.ignoreSearch,
    this.ignoreMethod,
    this.ignoreVary,
  });
}

// class MultiCacheQueryOptions extends CacheQueryOptions {
//   String? cacheName;

//   MultiCacheQueryOptions({
//     this.cacheName,
//     super.ignoreSearch,
//     super.ignoreMethod,
//     super.ignoreVary,
//   });
// }

// extension on MultiCacheQueryOptions {
//   interop.MultiCacheQueryOptions get delegate {
//     return interop.MultiCacheQueryOptions(
//       cacheName: cacheName ?? '',
//     )
//       ..ignoreMethod = ignoreMethod ?? false
//       ..ignoreVary = ignoreVary ?? false;
//   }
// }

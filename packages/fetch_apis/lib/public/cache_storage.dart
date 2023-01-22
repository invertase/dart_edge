import 'dart:js_util';

import 'package:js_bindings/js_bindings.dart' as interop;
import '../interop/fetch_interop.dart' as interop;
import '../interop/cache_interop.dart' as interop;
import 'cache.dart';
import 'request.dart';
import 'response.dart';

class CacheStorage {
  final interop.CacheStorage _delegate;

  CacheStorage._(this._delegate);

  Cache get defaultCache => cacheFromJsObject(interop.defaultCache);

  Future<bool> delete(String cacheName) async {
    return promiseToFuture(_delegate.delete(cacheName));
  }

  Future<bool> has(String cacheName) async {
    return promiseToFuture(_delegate.has(cacheName));
  }

  Future<Iterable<String>> keys() async {
    return _delegate.keys();
  }

  Future<Response?> match(Request request) async {
    final obj = await promiseToFuture<interop.Response?>(
        _delegate.match(request.delegate));
    return obj == null ? null : responseFromJsObject(obj);
  }

  Future<Cache> open(String name) async {
    return cacheFromJsObject(await promiseToFuture(_delegate.open(name)));
  }
}

final caches = CacheStorage._(interop.caches);

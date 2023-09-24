import 'dart:js_util';

import 'package:typings/core.dart' as interop;

import '../interop/utils_interop.dart' as interop;
import '../response.dart';
import 'cache_query_options.dart';

class Cache {
  final interop.Cache _delegate;

  Cache._(this._delegate);

  Future<void> add(interop.Request request) async {
    await _delegate.add(request);
  }

  Future<void> addAll(Iterable<interop.Request> requests) async {
    await _delegate.addAll(requests.toList());
  }

  Future<void> delete(interop.Request request, [MultiCacheQueryOptions? options]) async {
    await _delegate.delete(request, options?.delegate);
  }

  Future<Response?> match(interop.Request request, [CacheQueryOptions? options]) async {
    final obj = await promiseToFuture(_delegate.match(request, options?.delegate));
    return obj == null ? null : responseFromJsObject(obj);
  }

  Future<Iterable<Response>> matchAll(
      [interop.Request? request, CacheQueryOptions? options]) async {
    final matches = await _delegate.matchAll(
      request ?? interop.jsUndefined,
      options?.delegate,
    );
    return matches.map((obj, _, __) => responseFromJsObject(obj));
  }

  Future<void> put(
    interop.Request request,
    Response response,
  ) async {
    return _delegate.put(request, response.delegate);
  }
}

Cache cacheFromJsObject(interop.Cache delegate) {
  return Cache._(delegate);
}

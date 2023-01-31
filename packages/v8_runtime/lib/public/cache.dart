import 'dart:js_util';

import 'package:js_bindings/js_bindings.dart' as interop;

import '../interop/utils_interop.dart' as interop;
import 'request.dart';
import 'response.dart';

class Cache {
  final interop.Cache _delegate;

  Cache._(this._delegate);

  Future<void> add(Request request) async {
    await _delegate.add(request.delegate);
  }

  Future<void> addAll(Iterable<Request> requests) async {
    await _delegate.addAll(requests.map((r) => r.delegate).toList());
  }

  Future<void> delete(Request request) async {
    // TODO: support options
    await _delegate.delete(request.delegate);
  }

  Future<Response?> match(Request requst) async {
    // TODO: support options
    final obj = await promiseToFuture(_delegate.match(requst.delegate));
    return obj == null ? null : responseFromJsObject(obj);
  }

  Future<Iterable<Response>> matchAll([Request? request]) async {
    // TODO: support options
    final matches =
        await _delegate.matchAll(request?.delegate ?? interop.jsUndefined);
    return matches.map((obj) => responseFromJsObject(obj));
  }

  Future<void> put(
    Request request,
    Response response,
  ) async {
    return _delegate.put(request.delegate, response.delegate);
  }
}

Cache cacheFromJsObject(interop.Cache delegate) {
  return Cache._(delegate);
}

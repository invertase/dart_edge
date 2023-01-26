import 'dart:async';
import 'dart:js';
import 'dart:js_util';

import 'package:js_bindings/js_bindings.dart' as interop;
import 'package:v8_runtime/interop/promise_interop.dart';
import 'package:v8_runtime/public/request.dart';
import 'package:v8_runtime/public/response.dart';
import '../interop/durable_object_interop.dart' as interop;

import 'environment.dart';

abstract class DurableObject {
  final interop.DurableObject _delegate;

  final String name;

  DurableObjectState get state => DurableObjectState._(_delegate.state);

  Environment get env => environmentFromJsObject(_delegate.env);

  DurableObject(this.name) : _delegate = interop.DurableObject();

  void init() {}
  FutureOr<Response> fetch(Request request);
  FutureOr<void> alarm() {}
}

extension DurableObjectExtension on DurableObject {
  interop.DurableObject get delegate => _delegate;
}

class DurableObjectState {
  final interop.DurableObjectState _delegate;

  DurableObjectState._(this._delegate);

  DurableObjectId get id => DurableObjectId._(_delegate.id);
  DurableObjectStorage get storage => DurableObjectStorage._(_delegate.storage);

  void waitUntil(Future<void> future) => _delegate.waitUntil(future);

  Future<T> blockConcurrencyWhile<T>(Future<T> Function() callback) =>
      _delegate.blockConcurrencyWhile(allowInterop(callback));
}

class DurableObjectGetResult {
  final interop.DurableObjectGetResult _delegate;
  DurableObjectGetResult._(this._delegate);
  dynamic operator [](String name) => _delegate.getKey(name);
}

class DurableObjectStorage {
  final interop.DurableObjectStorage _delegate;

  DurableObjectStorage._(this._delegate);

  Future<T?> get<T>(
    String key, {
    bool allowConcurrency = false,
    bool noCache = false,
  }) async {
    final obj = await _delegate.get(
      key,
      interop.DurableObjectGetOptions(
        allowConcurrency: allowConcurrency,
        noCache: noCache,
      ),
    );

    if (obj is T) {
      return dartify(obj) as T;
    } else {
      return null;
    }
  }

  Future<DurableObjectGetResult> getKeys<T>(
    Iterable<String> keys, {
    bool allowConcurrency = false,
    bool noCache = false,
  }) async {
    final obj = await _delegate.get(
      keys,
      interop.DurableObjectGetOptions(
        allowConcurrency: allowConcurrency,
        noCache: noCache,
      ),
    );

    return DurableObjectGetResult._(obj);
  }

  Future<void> put<T>(
    String key,
    T value, {
    bool allowUnconfirmed = false,
    bool noCache = false,
  }) async {
    return _delegate.put(
      key,
      value,
      interop.DurableObjectPutOptions(
        allowUnconfirmed: allowUnconfirmed,
        noCache: noCache,
      ),
    );
  }
}

class DurableObjectNamespace {
  final interop.DurableObjectNamespace _delegate;

  DurableObjectNamespace._(this._delegate);

  DurableObjectId newUniqueId() => DurableObjectId._(_delegate.newUniqueId());
  DurableObjectId idFromName(String name) =>
      DurableObjectId._(_delegate.idFromName(name));
  DurableObjectId idFromString(String id) =>
      DurableObjectId._(_delegate.idFromString(id));
  DurableObjectStub get(DurableObjectId id) =>
      DurableObjectStub._(_delegate.get(id._delegate));
}

DurableObjectNamespace durableObjectNamespaceFromJsObject(
        interop.DurableObjectNamespace obj) =>
    DurableObjectNamespace._(obj);

class DurableObjectId {
  final interop.DurableObjectId _delegate;

  DurableObjectId._(this._delegate);

  String get name => _delegate.name;
  bool equals(DurableObjectId other) => _delegate.equals(other._delegate);

  @override
  String toString() => _delegate.mToString();
}

class DurableObjectStub extends Fetcher {
  final interop.DurableObjectStub _delegate;

  DurableObjectStub._(this._delegate) : super._(_delegate);

  DurableObjectId get id => DurableObjectId._(_delegate.id);
  String get name => _delegate.name;
}

class Fetcher {
  final interop.Fetcher _delegate;

  Fetcher._(this._delegate);

  Future<Response> fetch(Request request, [interop.RequestInit? init]) async {
    final response = await _delegate.fetch(request.delegate, init);
    return responseFromJsObject(response);
  }

  Socket connect(String address, [SocketOptions? options]) =>
      Socket._(_delegate.connect(address, options?._delegate));
}

class Socket {
  final interop.Socket _delegate;

  Socket._(this._delegate);

  Future<interop.ReadableStream> get readable => _delegate.readable;
  Future<interop.ReadableStream> get writable => _delegate.writable;
  Future<bool> get closed => _delegate.closed;
  Future<void> close() => _delegate.close();
}

class SocketOptions {
  final interop.SocketOptions _delegate;

  SocketOptions._(this._delegate);

  bool get tls => _delegate.tsl;
  set tls(bool value) => _delegate.tsl = value;
}

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
  late final interop.DurableObject _delegate;

  final String name;

  DurableObjectState get state => DurableObjectState._(_delegate.state);
  
  Environment get env => environmentFromJsObject(_delegate.env);

  DurableObject(this.name) {
    // Create the delegate instance of the object.
    _delegate = interop.DurableObject(fetch: allowInterop((fetchObj) {
      return futureToPromise(Future(() async {
        final r = await fetch(requestFromJsObject(fetchObj));
        return r.delegate;
      }));
    }));

    // Make sure the JS runtime has a place to store the objects
    interop.durableObjects ??= jsify({});

    interop.durableObjects = jsify({
      ...dartify(interop.durableObjects) as Map,
      name: _delegate,
    });
  }

  FutureOr<Response> fetch(Request request);
  FutureOr<void> alarm() {}
}

class DurableObjectState {
  final interop.DurableObjectState _delegate;

  DurableObjectState._(this._delegate);

  DurableObjectId get id => DurableObjectId._(_delegate.id);
  dynamic get storage => _delegate.storage;

  void waitUntil(Future<void> future) => _delegate.waitUntil(future);

  Future<T> blockConcurrencyWhile<T>(Future<T> Function() callback) =>
      _delegate.blockConcurrencyWhile(allowInterop(callback));
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

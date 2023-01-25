import 'dart:js_util' as js_util;
import 'package:js/js.dart';
import 'package:js/js_util.dart';
import 'package:js_bindings/js_bindings.dart' as interop;
import 'environment_interop.dart' as interop;
import 'package:v8_runtime/interop/promise_interop.dart';

@JS('__durableObjects')
external set durableObjects(dynamic value);

@JS('__durableObjects')
external dynamic get durableObjects;

@anonymous
@JS()
class DurableObject {
  external DurableObjectState get state;
  external set state(DurableObjectState state);
  external interop.Environment get env;
  external set env(interop.Environment env);
  external Promise<interop.Response> fetch(interop.Request request);
  external factory DurableObject({
    Promise<interop.Response> Function(interop.Request request) fetch,
    dynamic state,
  });
}

@anonymous
@JS()
@staticInterop
class DurableObjectState {
  external factory DurableObjectState();
}

extension PropsDurableObjectState on DurableObjectState {
  DurableObjectId get id => js_util.getProperty(this, 'id');
  // TODO
  dynamic get storage => js_util.getProperty(this, 'storage');

  void waitUntil(Future<void> f) =>
      js_util.callMethod(this, 'waitUntil', [futureToPromise(f)]);

  Future<T> blockConcurrencyWhile<T>(Future<T> Function() callback) {
    return js_util.promiseToFuture(
      js_util.callMethod(
        this,
        'blockConcurrencyWhile',
        [allowInterop(callback)],
      ),
    );
  }
}

@JS()
@staticInterop
class DurableObjectNamespace {
  external factory DurableObjectNamespace();
}

extension PropsDurableObjectNamespace on DurableObjectNamespace {
  // TODO options
  DurableObjectId newUniqueId() => js_util.callMethod(this, 'newUniqueId', []);
  DurableObjectId idFromName(String name) =>
      js_util.callMethod(this, 'idFromName', [name]);
  DurableObjectId idFromString(String id) =>
      js_util.callMethod(this, 'idFromString', [id]);
  DurableObjectStub get(DurableObjectId id) =>
      js_util.callMethod(this, 'get', [id]);
}

@JS()
@staticInterop
class DurableObjectId {
  external factory DurableObjectId();
}

extension PropsDurableObjectId on DurableObjectId {
  String get name => js_util.getProperty(this, 'name');
  bool equals(DurableObjectId other) =>
      js_util.callMethod(this, 'equals', [other]);
  String mToString() => js_util.callMethod(this, 'toString', []);
}

@JS()
@staticInterop
class Fetcher {
  external factory Fetcher();
}

extension PropsFetcher on Fetcher {
  // TODO RequestInit<RequestInitCfProperties>
  Future<interop.Response> fetch(interop.Request resource,
          [interop.RequestInit? init]) =>
      js_util
          .promiseToFuture(js_util.callMethod(this, 'fetch', [resource, init]));

  Socket connect(String address, [SocketOptions? options]) =>
      js_util.callMethod(this, 'connect', [address, options]);
}

@JS()
@staticInterop
class Socket {
  external factory Socket();
}

extension PropsSocket on Socket {
  Future<interop.ReadableStream> get readable =>
      js_util.getProperty(this, 'readable');
  Future<interop.ReadableStream> get writable =>
      js_util.getProperty(this, 'writable');
  Future<bool> get closed => js_util.getProperty(this, 'closed');
  Future<void> close() => js_util.callMethod(this, 'close', []);
}

@anonymous
@JS()
@staticInterop
class SocketOptions {
  external factory SocketOptions({bool tsl});
}

extension PropsSocketOptions on SocketOptions {
  bool get tsl => js_util.getProperty(this, 'tsl');
  set tsl(bool newValue) => js_util.setProperty(this, 'tsl', newValue);
}

@JS()
@staticInterop
class DurableObjectStub extends Fetcher {
  external factory DurableObjectStub();
}

extension PropsDurableObjectStub on DurableObjectStub {
  DurableObjectId get id => js_util.getProperty(this, 'id');
  String get name => js_util.getProperty(this, 'name');
}

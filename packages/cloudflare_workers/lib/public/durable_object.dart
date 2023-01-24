import 'package:js_bindings/js_bindings.dart' as interop;
import '../interop/durable_object_interop.dart' as interop;

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

DurableObjectNamespace kvNamespaceFromJsObject(
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

  Future<interop.Response> fetch(interop.Request resource,
          [interop.RequestInit? init]) =>
      _delegate.fetch(resource, init);

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

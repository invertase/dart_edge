import '../interop/kv_namespace_interop.dart' as interop;

class KVNamespace {
  final interop.KVNamespace _delegate;

  KVNamespace._(this._delegate);

  // TODO
}

KVNamespace kvNamespaceFromJsObject(interop.KVNamespace obj) =>
    KVNamespace._(obj);

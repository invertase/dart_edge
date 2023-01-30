import '../../interop/durable_object_interop.dart' as interop;

import 'durable_object_id.dart';
import 'durable_object_stub.dart';

class DurableObjectNamespace {
  final interop.DurableObjectNamespace _delegate;

  DurableObjectNamespace._(this._delegate);

  DurableObjectId newUniqueId(
          [DurableObjectNamespaceNewUniqueIdOptions? options]) =>
      durableObjectIdFromJsObject(_delegate.newUniqueId(options?.delegate ??
          interop.DurableObjectNamespaceNewUniqueIdOptions()));
  DurableObjectId idFromName(String name) =>
      durableObjectIdFromJsObject(_delegate.idFromName(name));
  DurableObjectId idFromString(String id) =>
      durableObjectIdFromJsObject(_delegate.idFromString(id));
  DurableObjectStub get(DurableObjectId id) =>
      durableObjectStubFromJsObject(_delegate.get(id.delegate));
}

DurableObjectNamespace durableObjectNamespaceFromJsObject(
        interop.DurableObjectNamespace obj) =>
    DurableObjectNamespace._(obj);

class DurableObjectNamespaceNewUniqueIdOptions {
  String? jurisdiction;

  DurableObjectNamespaceNewUniqueIdOptions({this.jurisdiction});
}

extension on DurableObjectNamespaceNewUniqueIdOptions {
  interop.DurableObjectNamespaceNewUniqueIdOptions get delegate =>
      interop.DurableObjectNamespaceNewUniqueIdOptions(
        jurisdiction: jurisdiction,
      );
}

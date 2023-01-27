import 'dart:async';
import 'dart:js_util';

import '../../interop/durable_object_interop.dart' as interop;

class DurableObjectStorage {
  final interop.DurableObjectStorage _delegate;

  DurableObjectStorage._(this._delegate);

  Future<DurableObjectStorageGetResult> get(
    String key, {
    bool allowConcurrency = false,
    bool noCache = false,
  }) async {
    return DurableObjectStorageGetResult._(
      await _delegate.get(
        key,
        interop.DurableObjectGetOptions(
          allowConcurrency: allowConcurrency,
          noCache: noCache,
        ),
      ),
    );
  }

  Future<Map<String, DurableObjectStorageGetResult>> getEntries(
    Iterable<String> keys, {
    bool allowConcurrency = false,
    bool noCache = false,
  }) async {
    // TODO: implement - returns a JS Map (not object).
    throw UnimplementedError();
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

  Future<void> putEntries<T>(
    Map<Object, T> entries, {
    bool allowUnconfirmed = false,
    bool noCache = false,
  }) async {
    return _delegate.putEntries<T>(
      entries,
      interop.DurableObjectPutOptions(
        allowUnconfirmed: allowUnconfirmed,
        noCache: noCache,
      ),
    );
  }

  Future<bool> delete(dynamic key) async {
    return _delegate.delete(key);
  }

  Future<bool> deleteEntries(
    Iterable<String> keys, {
    bool allowUnconfirmed = false,
    bool noCache = false,
  }) async {
    return _delegate.deleteEntries(
        keys,
        interop.DurableObjectPutOptions(
          allowUnconfirmed: allowUnconfirmed,
          noCache: noCache,
        ));
  }

  // TODO list options
  Future<Map<String, DurableObjectStorageGetResult>> list() async {
    throw UnimplementedError();
  }

  Future<void> transaction(Future<void> Function(dynamic tsx) callback) async {
    throw UnimplementedError();
  }

  // TODO: Supported options: Like get() above, but without noCache.
  Future<num?> deleteAll() async {
    throw UnimplementedError();
  }

  // TODO: Supported options: Like get() above, but without noCache.
  Future<num?> getAlarm() async {
    throw UnimplementedError();
  }

  // TODO Supported options: Like put() above, but without noCache.
  Future<void> setAlarm() async {
    throw UnimplementedError();
  }

  // TODO: Supported options: Like put() above, but without noCache.
  Future<void> deleteAlarm() async {
    throw UnimplementedError();
  }

  Future<void> sync() async {
    throw UnimplementedError();
  }
}

extension DurableObjectStorageExtension on DurableObjectStorage {
  interop.DurableObjectStorage get delegate => _delegate;
}

DurableObjectStorage durableObjectStorageFromJsObject(
  interop.DurableObjectStorage obj,
) =>
    DurableObjectStorage._(obj);

class DurableObjectStorageGetResult {
  final dynamic _delegate;

  DurableObjectStorageGetResult._(this._delegate);

  // TODO: is this the best way? Or should we just get<T>
  String? get stringValue => _delegate?.toString();
  num? get numberValue => num.tryParse(stringValue ?? '');
  bool? get boolValue => stringValue == null
      ? null
      : stringValue?.toLowerCase() == 'true'
          ? true
          : false;
  Map<Object, Object?>? get mapValue =>
      dartify(_delegate) as Map<Object, Object?>?;
  List<Object?>? get listValue => dartify(_delegate) as List<Object?>?;
}

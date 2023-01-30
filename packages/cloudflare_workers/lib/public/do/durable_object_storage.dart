import 'dart:async';
import 'dart:js_util';

import '../../interop/durable_object_interop.dart' as interop;
import './durable_object_storage_options.dart';

class DurableObjectStorage {
  final interop.DurableObjectStorage _delegate;

  DurableObjectStorage._(this._delegate);

  Future<T?> get<T>(String key, [DurableObjectGetOptions? options]) async {
    final obj = await _delegate.get(
      key,
      options?.delegate ?? interop.DurableObjectGetOptions(),
    );

    return obj == null ? null : dartify(obj) as T;
  }

  Future<Map<String, T>> getEntries<T>(Iterable<String> keys,
      [DurableObjectGetOptions? options]) async {
    final obj = await _delegate.get(
      keys,
      options?.delegate ?? interop.DurableObjectGetOptions(),
    );

    return dartify(obj) as Map<String, T>;
  }

  Future<void> put<T>(
    String key,
    T value, [
    DurableObjectPutOptions? options,
  ]) async {
    return _delegate.put(
      key,
      value,
      options?.delegate ?? interop.DurableObjectPutOptions(),
    );
  }

  Future<void> putEntries<T>(Map<Object, T> entries,
      [DurableObjectPutOptions? options]) async {
    return _delegate.putEntries<T>(
      entries,
      options?.delegate ?? interop.DurableObjectPutOptions(),
    );
  }

  Future<bool> delete(String key, [DurableObjectPutOptions? options]) async {
    return _delegate.delete(
      key,
      options?.delegate ?? interop.DurableObjectPutOptions(),
    );
  }

  Future<void> deleteAll([DurableObjectPutOptions? options]) async {
    return _delegate.deleteAll(
      options?.delegate ?? interop.DurableObjectPutOptions(),
    );
  }

  Future<bool> deleteEntries(
    Iterable<String> keys, [
    DurableObjectPutOptions? options,
  ]) async {
    return _delegate.deleteEntries(
      keys,
      options?.delegate ?? interop.DurableObjectPutOptions(),
    );
  }

  Future<Map<String, T>> list<T>([DurableObjectListOptions? options]) async {
    final obj = await _delegate.list(
      options?.delegate ?? interop.DurableObjectListOptions(),
    );

    return dartify(obj) as Map<String, T>;
  }

  Future<void> transaction(
      Future<void> Function(DurableObjectTransaction tsx) callback) async {
    return _delegate.transaction((tsx) async {
      return callback(DurableObjectTransaction._(tsx));
    });
  }

  Future<int?> getAlarm([DurableObjectGetAlarmOptions? options]) async {
    return _delegate.getAlarm(
      options?.delegate ?? interop.DurableObjectGetAlarmOptions(),
    );
  }

  Future<void> setAlarm(DateTime scheduledTime,
      [DurableObjectSetAlarmOptions? options]) async {
    return _delegate.setAlarm(
      scheduledTime,
      options?.delegate ?? interop.DurableObjectSetAlarmOptions(),
    );
  }

  Future<void> deleteAlarm([DurableObjectSetAlarmOptions? options]) async {
    return _delegate.deleteAlarm(
      options?.delegate ?? interop.DurableObjectSetAlarmOptions(),
    );
  }

  Future<void> sync() async {
    return _delegate.sync();
  }
}

extension DurableObjectStorageExtension on DurableObjectStorage {
  interop.DurableObjectStorage get delegate => _delegate;
}

DurableObjectStorage durableObjectStorageFromJsObject(
  interop.DurableObjectStorage obj,
) =>
    DurableObjectStorage._(obj);

class DurableObjectTransaction extends DurableObjectStorage {
  final interop.DurableObjectTransaction _tsxDelegate;
  DurableObjectTransaction._(this._tsxDelegate) : super._(_tsxDelegate);

  void rollback() {
    _tsxDelegate.rollback();
  }
}

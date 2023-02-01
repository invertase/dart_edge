import 'dart:typed_data';

import 'package:edge/runtime/interop/utils_interop.dart';
import 'package:edge/runtime/readable_stream.dart';

import '../interop/kv_namespace_interop.dart' as interop;

class KVNamespace {
  final interop.KVNamespace _delegate;

  KVNamespace._(this._delegate);

  Future<String> get(String name, [KVNamespaceGetOptions? options]) =>
      _delegate.get(name, options?.delegate('text'));

  Future<KVNamespaceGetWithMetadataResult<String>> getWithMetadata(
    String name, [
    KVNamespaceGetOptions? options,
  ]) async {
    return KVNamespaceGetWithMetadataResult._(
      await _delegate.getWithMetadata(
          name, (options ?? KVNamespaceGetOptions()).delegate('text')),
    );
  }

  Future<Map<K, V>> getJson<K, V>(String name,
      [KVNamespaceGetOptions? options]) async {
    final json = await _delegate.get(
        name, (options ?? KVNamespaceGetOptions()).delegate('json'));
    return dartify(json) as Map<K, V>;
  }

  Future<KVNamespaceGetWithMetadataResult<Map<K, V>>> getJsonWithMetadata<K, V>(
    String name, [
    KVNamespaceGetOptions? options,
  ]) async {
    return KVNamespaceGetWithMetadataResult._(
      await _delegate.getWithMetadata(
          name, (options ?? KVNamespaceGetOptions()).delegate('json')),
    );
  }

  Future<ByteBuffer> getBuffer(String name, [KVNamespaceGetOptions? options]) =>
      _delegate.get(
          name, (options ?? KVNamespaceGetOptions()).delegate('arrayBuffer'));

  Future<KVNamespaceGetWithMetadataResult<ByteBuffer>> getBufferWithMetadata(
    String name, [
    KVNamespaceGetOptions? options,
  ]) async {
    return KVNamespaceGetWithMetadataResult._(
      await _delegate.getWithMetadata(
          name, (options ?? KVNamespaceGetOptions()).delegate('arrayBuffer')),
    );
  }

  Future<ReadableStream> getStream(String name,
      [KVNamespaceGetOptions? options]) async {
    final stream = await _delegate.get(
        name, (options ?? KVNamespaceGetOptions()).delegate('stream'));
    return readableStreamFromJsObject(stream);
  }

  Future<KVNamespaceGetWithMetadataResult<ReadableStream>>
      getStreamWithMetadata(
    String name, [
    KVNamespaceGetOptions? options,
  ]) async {
    return KVNamespaceGetWithMetadataResult._(
      await _delegate.getWithMetadata(
          name, (options ?? KVNamespaceGetOptions()).delegate('stream')),
    );
  }

  Future<void> put(
    String key,
    Object value, [
    KVNamespacePutOptions? options,
  ]) =>
      _delegate.put(key, value, (options ?? KVNamespacePutOptions()).delegate);

  Future<void> delete(Iterable<String> keys) => _delegate.delete(keys);

  Future<KVNamespaceListResult> list([KVNamespaceListOptions? options]) async =>
      KVNamespaceListResult._(
          await _delegate.list((options ?? KVNamespaceListOptions()).delegate));
}

KVNamespace kvNamespaceFromJsObject(interop.KVNamespace obj) =>
    KVNamespace._(obj);

class KVNamespaceGetWithMetadataResult<T> {
  final interop.KVNamespaceGetWithMetadataResult<T> _delegate;
  KVNamespaceGetWithMetadataResult._(this._delegate);
  T get value => dartify(_delegate.value);
  Object? get metadata => dartify(_delegate.metadata);
}

class KVNamespaceGetOptions {
  int? cacheTtl;

  KVNamespaceGetOptions({
    this.cacheTtl,
  });
}

extension on KVNamespaceGetOptions {
  interop.KVNamespaceGetOptions delegate(String type) {
    return interop.KVNamespaceGetOptions()
      ..type = type
      ..cacheTtl = cacheTtl;
  }
}

class KVNamespacePutOptions {
  DateTime? expiration;
  int? expirationTtl;
  Object? metadata;

  KVNamespacePutOptions({
    this.expiration,
    this.expirationTtl,
    this.metadata,
  });
}

extension on KVNamespacePutOptions {
  interop.KVNamespacePutOptions get delegate {
    return interop.KVNamespacePutOptions()
      ..expiration = expiration
      ..expirationTtl = expirationTtl
      ..metadata = metadata;
  }
}

class KVNamespaceListResult {
  final interop.KVNamespaceListResult _delegate;
  KVNamespaceListResult._(this._delegate);
  Iterable<KVNamespaceListKey> get keys sync* {
    // TODO fix me.
    throw UnimplementedError('Returns a JsArray/List, but its not iterable?');
    for (var i = 0; i < _delegate.keys.length; i++) {
      yield KVNamespaceListKey._(_delegate.keys[i]);
    }
  }

  bool get listComplete => _delegate.listComplete;
  String? get cursor => _delegate.cursor;
}

class KVNamespaceListKey {
  final interop.KVNamespaceListKey _delegate;
  KVNamespaceListKey._(this._delegate);
  String get name => _delegate.name;
  Object? get metadata => _delegate.metadata;
}

class KVNamespaceListOptions {
  int? limit;
  String? prefix;
  String? cursor;

  KVNamespaceListOptions({
    this.limit,
    this.prefix,
    this.cursor,
  });
}

extension on KVNamespaceListOptions {
  interop.KVNamespaceListOptions get delegate {
    return interop.KVNamespaceListOptions()
      ..limit = limit
      ..prefix = prefix
      ..cursor = cursor;
  }
}

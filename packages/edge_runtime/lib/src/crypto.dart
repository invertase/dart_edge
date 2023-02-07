import 'dart:typed_data';

import 'package:js_bindings/js_bindings.dart' as interop;
import 'interop/crypto_interop.dart' as interop;

export 'package:js_bindings/js_bindings.dart' show KeyFormat, KeyType;

final crypto = Crypto._(interop.crypto);

class Crypto {
  final interop.Crypto _delegate;

  Crypto._(this._delegate);

  SubtleCrypto get subtle => SubtleCrypto._(_delegate.subtle);

  // TODO Is this the right way to do this?
  TypedData getRandomValues(TypedData typedArray) =>
      _delegate.getRandomValues(typedArray);

  String randomUUID() => _delegate.randomUUID();
}

class SubtleCrypto {
  final interop.SubtleCrypto _delegate;

  SubtleCrypto._(this._delegate);

  Future<ByteBuffer> encrypt(
    Algorithm algorithm,
    CryptoKey key,
    dynamic data,
  ) {
    final obj = _delegate.encrypt(algorithm._delegate, key._delegate, data);
    throw UnimplementedError('TODO - how to handle return type?');
  }

  // TODO decrypt
  // TODO sign
  // TODO verify
  // TODO digest
  // TODO generateKey
  // TODO deriveKey
  // TODO deriveBits
  // TODO importKey
  // TODO exportKey
  // TODO wrapKey
  // TODO unwrapKey
}

abstract class Algorithm {
  final interop.Algorithm _delegate;
  Algorithm._(this._delegate);
  String get name => _delegate.name;
}

class RsaOaepParams extends Algorithm {
  final interop.RsaOaepParams _rsaDelegate;

  RsaOaepParams._(this._rsaDelegate)
      : super._(interop.Algorithm(name: 'RSA-OAEP'));

  factory RsaOaepParams({
    ByteBuffer? label,
  }) =>
      RsaOaepParams._(interop.RsaOaepParams(
        label: label,
      ));

  ByteBuffer? get label => _rsaDelegate.label;
  set label(ByteBuffer? value) => _rsaDelegate.label = value;
}

class CryptoKey {
  final interop.CryptoKey _delegate;

  CryptoKey._(this._delegate);

  interop.KeyType get type => _delegate.type;
  bool get extractable => _delegate.extractable;
  List<String> get usages => _delegate.usages;
}

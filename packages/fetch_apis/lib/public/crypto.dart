import 'package:js_bindings/js_bindings.dart' as interop;
import '../interop/crypto_interop.dart' as interop;

export 'package:js_bindings/js_bindings.dart' show KeyFormat;

class Crypto {
  final interop.Crypto _delegate;

  Crypto._(this._delegate);

  SubtleCrypto get subtle => SubtleCrypto._(_delegate.subtle);

  // TODO getRandomValues

  String randomUUID() => _delegate.randomUUID();
}

class SubtleCrypto {
  final interop.SubtleCrypto _delegate;

  SubtleCrypto._(this._delegate);

  // TODO encrypt
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

final crypto = Crypto._(interop.crypto);

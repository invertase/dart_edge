import 'dart:js_util' show jsify;

import 'package:js_bindings/js_bindings.dart' as interop;

class AbortSignal {
  final interop.AbortSignal _delegate;

  AbortSignal() : _delegate = interop.AbortSignal();

  AbortSignal._(this._delegate);

  static AbortSignal abort([Object? reason]) {
    // TODO check this works calling extension method
    if (reason == null) return AbortSignal._(interop.PropsAbortSignal.abort());
    return AbortSignal._(interop.PropsAbortSignal.abort(jsify(reason)));
  }

  static AbortSignal timeout(int delay) {
    return AbortSignal._(interop.PropsAbortSignal.timeout(delay));
  }

  bool get aborted => _delegate.aborted;
  Object get reason => _delegate.reason;
  void throwIfAborted() => _delegate.throwIfAborted();
}

extension AbortSignalExtension on AbortSignal {
  interop.AbortSignal get delegate => _delegate;
}

AbortSignal abortSignalToJsObject(interop.AbortSignal abortSignal) {
  return AbortSignal._(abortSignal);
}

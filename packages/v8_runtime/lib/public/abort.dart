import 'dart:js_util' show jsify;

import 'package:js_bindings/js_bindings.dart' as interop;
import 'package:v8_runtime/interop/utils_interop.dart';

class AbortController {
  final interop.AbortController _delegate;
  AbortController() : _delegate = interop.AbortController();

  AbortSignal get signal => AbortSignal._(_delegate.signal);
  void abort([Object? reason]) =>
      _delegate.abort(reason != null ? jsify(reason) : jsUndefined);
}

class AbortSignal {
  final interop.AbortSignal _delegate;

  AbortSignal() : _delegate = interop.AbortSignal();

  AbortSignal._(this._delegate);

  static AbortSignal abort([Object? reason]) {
    // TODO: This won't work, see https://github.com/jodinathan/js_bindings/issues/25
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

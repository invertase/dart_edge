import 'dart:js_util' as js_util;
import 'package:js/js.dart';

@JS()
@staticInterop
class Symbol {
  external factory Symbol();
}

@JS('Symbol.asyncIterator')
external Symbol get asyncIterator;

@anonymous
@JS()
@staticInterop
class AsyncIterator<T> {
  external factory AsyncIterator();
}

extension PropsAsyncIterator<T> on AsyncIterator<T> {
  Stream<T> toStream<T>() async* {
    final iterator = js_util.getProperty(this, asyncIterator);
    final callable = js_util.callMethod(iterator, 'call', []);

    while (true) {
      final result = await _next<T>(callable);
      if (result.done) {
        break;
      }
      yield result.value;
    }
  }

  Future<IteratorResult<T>> _next<T>(dynamic iteratorInstance) {
    return js_util.promiseToFuture(
      js_util.callMethod(iteratorInstance, 'next', []),
    );
  }
}

@anonymous
@JS()
@staticInterop
class IteratorResult<T> {
  external factory IteratorResult();
}

extension PropsIteratorResult<T> on IteratorResult<T> {
  bool get done => js_util.getProperty(this, 'done');
  T get value => js_util.getProperty(this, 'value');
}

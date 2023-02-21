import 'package:js/js.dart';
import 'dart:js_util' as js_util;

@anonymous
@JS()
@staticInterop
class AsyncIterator<T> {
  external factory AsyncIterator();
}

extension PropsAsyncIterator<T> on AsyncIterator {
  Future<IteratorResult<T>> next() => js_util.promiseToFuture(
        js_util.callMethod(this, 'next', []),
      );
}

@anonymous
@JS()
@staticInterop
class IteratorResult<T> {
  external factory IteratorResult();
}

extension PropsIteratorResult<T> on IteratorResult {
  bool get done => js_util.getProperty(this, 'done');
  T get value => js_util.getProperty(this, 'value');
}

@JS('Deno.env')
@staticInterop
external Env get env;

@JS('Deno.cwd')
@staticInterop
external String cwd();

@JS('Deno.readDir')
@staticInterop
external AsyncIterator<DirEntry> readDir(String path);

@JS()
@anonymous
@staticInterop
class Env {
  external factory Env();
}

extension PropsEnv on Env {
  String? get(String key) => js_util.callMethod(this, 'get', [key]);
  void set(String key, String value) =>
      js_util.callMethod(this, 'set', [key, value]);
  void delete(String key) => js_util.callMethod(this, 'delete', [key]);
  bool has(String key) => js_util.callMethod(this, 'has', [key]);
  dynamic toObject() => js_util.callMethod(this, 'toObject', []);
}

@JS()
@anonymous
@staticInterop
class DirEntry {
  external factory DirEntry();
}

extension PropsDirEntry on DirEntry {
  String get name => js_util.getProperty(this, 'name');
  bool get isFile => js_util.getProperty(this, 'isFile');
  bool get isDirectory => js_util.getProperty(this, 'isDirectory');
  bool get isSymlink => js_util.getProperty(this, 'isSymlink');
}

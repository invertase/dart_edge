import 'package:js_bindings/js_bindings.dart' as interop;

import 'blob.dart';

class FormData {
  final interop.FormData _delegate;
  FormData._(this._delegate);

  FormData() : _delegate = interop.FormData();

  // TODO - FormDataEntryValue - see target
  void append(String name, [Blob? value, String? filename]) {
    _delegate.append(name, value?.delegate, filename);
  }

  void delete(String name) => _delegate.delete(name);
  bool has(String name) => _delegate.has(name);

  // TODO - FormDataEntryValue - see target
  Iterable<dynamic> getAll(String name) => _delegate.getAll(name);

  // TODO - FormDataEntryValue - see target
  operator []=(String name, Object? value) {
    throw UnimplementedError();
    // _delegate.mSet(name, value);
  }

  // TODO - FormDataEntryValue - see target
  dynamic operator [](String name) {
    return _delegate.mGet(name);
  }
}

FormData formDataFromJsObject(interop.FormData delegate) {
  return FormData._(delegate);
}

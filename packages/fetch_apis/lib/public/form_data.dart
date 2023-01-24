import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:js_bindings/js_bindings.dart' as interop;

import 'blob.dart';

part 'form_data.freezed.dart';

class FormData {
  final interop.FormData _delegate;
  FormData._(this._delegate);

  FormData() : _delegate = interop.FormData();

  // TODO - FormDataEntryValue - see target
  void append(String name, FormDataEntryValue value) {
    value.when(file: (value) {
      throw UnimplementedError();
    }, string: (value) {
      // TODO even though the JS api accepts a string, it seems to only
      // accept a blob?
      throw UnimplementedError();
      // _delegate.append(name, value);
    });
    // _delegate.append(name, value?.delegate, filename);
  }

  void delete(String name) => _delegate.delete(name);

  bool has(String name) => _delegate.has(name);

  Iterable<FormDataEntryValue> getAll(String name) {
    final values = _delegate.getAll(name);

    return values.map((value) {
      if (value is String) {
        return FormDataEntryValue.string(value);
      } else if (value is interop.Blob) {
        return FormDataEntryValue.file(FormDataEntryFile());
      }

      throw StateError('Unknown FormDataEntryValue type: $value');
    });
  }

  // TODO - String to blob?
  operator []=(String name, FormDataEntryValue value) {
    value.when(file: (value) {
      throw UnimplementedError();
    }, string: (value) {
      // TODO even though the JS api accepts a string, it seems to only
      // accept a blob?
      throw UnimplementedError();
      // _delegate.mSet(name, value);
    });
  }

  // TODO - FormDataEntryValue - see target
  FormDataEntryValue? operator [](String name) {
    final value = _delegate.mGet(name);

    if (value is String) {
      return FormDataEntryValue.string(value);
    } else if (value is interop.Blob) {
      return FormDataEntryValue.file(FormDataEntryFile());
    }

    return null;
  }
}

FormData formDataFromJsObject(interop.FormData delegate) {
  return FormData._(delegate);
}

// TODO - see target - or is this a blob
class FormDataEntryFile {}

/// Represents a form data entry.
@Freezed(
  equal: false,
  copyWith: false,
  map: FreezedMapOptions.none,
  when: FreezedWhenOptions(
    whenOrNull: false,
    maybeWhen: false,
  ),
)
class FormDataEntryValue with _$FormDataEntryValue {
  const factory FormDataEntryValue.file(FormDataEntryFile file) = FileValue;

  /// Creates a [FormDataEntryValue] instance from a [String].
  const factory FormDataEntryValue.string(String value) = StringValue;
}

import 'dart:async';

import 'package:v8_runtime/public/request.dart';
import 'package:v8_runtime/public/response.dart';
import '../../interop/durable_object_interop.dart' as interop;

import '../environment.dart';
import 'durable_object_state.dart';

abstract class DurableObject {
  final interop.DurableObject _delegate;

  final String name;

  DurableObjectState get state =>
      durableObjectStateFromJsObject(_delegate.state);

  Environment get env => environmentFromJsObject(_delegate.env);

  DurableObject(this.name) : _delegate = interop.DurableObject();

  void init() {}
  FutureOr<Response> fetch(Request request);
  FutureOr<void> alarm() {}
}

extension DurableObjectExtension on DurableObject {
  interop.DurableObject get delegate => _delegate;
}

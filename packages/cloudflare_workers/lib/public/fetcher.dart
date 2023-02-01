import 'dart:async';

import 'package:edge/runtime/request.dart';
import 'package:edge/runtime/request_init.dart';
import 'package:edge/runtime/response.dart';
import '../interop/durable_object_interop.dart' as interop;

import 'socket.dart';

abstract class Fetcher {
  final interop.Fetcher _delegate;

  Fetcher(this._delegate);

  Future<Response> fetch(Request request, [RequestInit? init]) async {
    final response = await _delegate.fetch(request.delegate, init?.delegate);
    return responseFromJsObject(response);
  }

  Socket connect(String address, [SocketOptions? options]) =>
      socketFromJsObject(_delegate.connect(address, options?.delegate));
}

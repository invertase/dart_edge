import 'package:edge/runtime/headers.dart';
import 'package:edge/runtime/readable_stream.dart';
import 'package:edge/runtime.dart' show Headers, ReadableStream;
import '../interop/email_message_interop.dart' as interop;

class EmailMessage {
  final interop.EmailMessage _delegate;

  EmailMessage._(this._delegate);

  String get from => _delegate.from;
  String get to => _delegate.to;
  Headers get headers => headersFromJsObject(_delegate.headers);
  ReadableStream get raw => readableStreamFromJsObject(_delegate.raw);
  int get rawSize => _delegate.rawSize;

  void setReject(String reason) => _delegate.setReject(reason);

  Future<void> forward(String to, Headers? headers) =>
      _delegate.forward(to, headers?.delegate);
}

EmailMessage emailMessageFromJsObject(interop.EmailMessage obj) =>
    EmailMessage._(obj);

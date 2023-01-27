import '../interop/context_interop.dart' as interop;

class NetlifyContext {
  final interop.NetlifyContext _delegate;
  NetlifyContext._(this._delegate);

  Account get account => Account._(_delegate.account);
}

NetlifyContext netlifyContextFromJsObject(interop.NetlifyContext delegate) =>
    NetlifyContext._(delegate);

class Account {
  final interop.Account _delegate;
  Account._(this._delegate);

  String get id => _delegate.id;
}

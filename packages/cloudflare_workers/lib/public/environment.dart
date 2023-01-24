import '../interop/environment_interop.dart' as interop;

class Environment {
  final interop.Environment _delegate;

  Environment._(this._delegate);

  T read<T>(String name) => _delegate.read(name);
}

Environment environmentFromJsObject(interop.Environment obj) =>
    Environment._(obj);

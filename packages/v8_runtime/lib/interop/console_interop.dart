import 'package:js/js.dart' as js;

@js.JS('console.log')
external void _consoleLog(Object? object);

@js.JS('console.warn')
external void _consoleWarn(Object? object);

@js.JS('console.error')
external void _consoleError(Object? object);

@js.JS('console.dir')
external void _consoleDir(Object? object);

class _Console {
  const _Console._();
  void log(Object? object) => _consoleLog(object);
  void warn(Object? object) => _consoleWarn(object);
  void error(Object? object) => _consoleError(object);
  void dir(Object? object) => _consoleDir(object);
}

const console = _Console._();

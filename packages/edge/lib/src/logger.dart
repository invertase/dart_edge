import 'dart:io' as io;
import 'package:ansi_styles/ansi_styles.dart';
import 'package:cli_util/cli_logging.dart';

export 'package:ansi_styles/extension.dart';

final successMessageColor = AnsiStyles.green;
final warningMessageColor = AnsiStyles.yellow;
final errorMessageColor = AnsiStyles.red;
final hintMessageColor = AnsiStyles.gray;

Logger? _globalLogger;

/// Initializes the global logger.
void initLogger(Logger logger) {
  if (_globalLogger != null) {
    return;
  }
  _globalLogger = logger;
}

/// Returns the global logger.
_Logger get logger {
  if (_globalLogger == null) {
    throw StateError('Logger not initialized');
  }
  return _Logger(_globalLogger!);
}

/// A utility class that wraps the [Logger] class, providing some useful
/// methods for logging success, warning, error, and hint messages.
class _Logger {
  final Logger _delegate;
  _Logger(this._delegate);

  int _terminalWidth = io.stdout.hasTerminal ? io.stdout.terminalColumns : 80;

  void stdout(String message) {
    _delegate.stdout(message);
  }

  void stderr(String message) {
    _delegate.stdout(message);
  }

  void verbose(String message) {
    _delegate.trace(message);
  }

  void write(String message) {
    _delegate.stdout(message);
  }

  Progress progress(String message) {
    return _delegate.progress(message);
  }

  void hint(String message) {
    stdout(hintMessageColor(message));
  }

  void success(String message) {
    stdout(successMessageColor(message));
  }

  void warning(String message) {
    stdout(warningMessageColor(message));
  }

  void error(String message) {
    stderr(errorMessageColor(message));
  }

  void lineBreak() => stdout('');

  void horizontalLine() => stdout('-' * _terminalWidth);
}

extension LoggerStringX on String {
  String indent(int width) {
    return (' ' * width) + this;
  }

  String prefix(String char) {
    return hintMessageColor(char) + ' ' + this;
  }
}

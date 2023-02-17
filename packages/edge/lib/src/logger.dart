import 'package:mason_logger/mason_logger.dart';
import 'package:ansi_styles/ansi_styles.dart';

extension LoggerExtension on Logger {
  void lineBreak() => write('\n');
}

extension StringExtension on String {
  String indent(int width) {
    return (' ' * width) + this;
  }

  String prefix(String char) {
    return AnsiStyles.gray(char) + ' ' + this;
  }
}

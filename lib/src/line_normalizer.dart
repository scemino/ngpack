import 'dart:convert';

/// Normalizes line feed '\r\n' and '\r' to '\n'.
class LineNormalizer extends Converter<String, String> {
  static const String _LF = '\n';

  @override
  String convert(String input) {
    return input.replaceAll(RegExp(r'\r?\n|\r'), _LF);
  }
}

import 'package:logger/web.dart';

import 'constants.dart';

final class Log {
  static const String _defaultTag = 'HK_LOG';
  static const bool _isDebugMode = true;

  static final _logger = Logger(
    printer: PrettyPrinter(),
  );

  static i(String message, [String tag = _defaultTag, bool isTagEnable = true]) {
    if (!_isDebugMode) return;
    final String tag = isTagEnable ? _defaultTag : emptyString;
    _logger.i('$tag: $message');
  }

  static d(String message, [String tag = _defaultTag, bool isTagEnable = true]) {
    if (!_isDebugMode) return;
    final String tag = isTagEnable ? _defaultTag : emptyString;
    _logger.d('$tag: $message');
  }

  static e(String message, [String tag = _defaultTag, bool isTagEnable = true]) {
    if (!_isDebugMode) return;
    final String tag = isTagEnable ? _defaultTag : emptyString;
    _logger.e('$tag: $message');
  }
}

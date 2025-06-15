import 'package:dio/dio.dart';
import 'package:flutter_timezone/flutter_timezone.dart';

class TimeZoneInterceptor extends Interceptor {
  final Dio dio;
  String? _cachedTimeZone;

  TimeZoneInterceptor(this.dio);

  Future<String> _getTimeZone() async {
    if (_cachedTimeZone != null) return _cachedTimeZone!;
    _cachedTimeZone = await FlutterTimezone.getLocalTimezone();
    return _cachedTimeZone!;
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final timeZone = await _getTimeZone();
    options.headers['x-timezone'] = timeZone;
    super.onRequest(options, handler);
  }
}

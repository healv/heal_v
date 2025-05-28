import 'package:shared_preferences/shared_preferences.dart';

class Store {
  static Future<void> set({
    required String key,
    required dynamic value,
  }) async {
    // SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    if (value is String) {
      await prefs.setString(key, value);
    } else if (value is int) {
      await prefs.setInt(key, value);
    } else if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is List<String>) {
      await prefs.setStringList(key, value);
    }
  }

  static void delete({
    required String key,
  }) async {
    // SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  static Future<T> get<T>({
    required String key,
    required T defaultValue,
  }) async {
    // SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    dynamic value;
    if (T == String) {
      value = prefs.getString(key);
    } else if (T == int) {
      value = prefs.getInt(key);
    } else if (T == bool || null is T) {
      value = prefs.getBool(key);
    } else if (T == List<String>) {
      value = prefs.getStringList(key);
    }
    if (value != null) {
      return value as T;
    }
    return defaultValue;
  }
}

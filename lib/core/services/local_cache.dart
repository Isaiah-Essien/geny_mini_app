import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


// Simple local cache using SharedPreferences for persistence.
class LocalCache {
  static const _kBusinesses = 'cache_businesses_v1';

  Future<void> saveBusinessesJson(List<Map<String, dynamic>> list) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kBusinesses, jsonEncode(list));
  }

  Future<List<Map<String, dynamic>>?> readBusinessesJson() async {
    final prefs = await SharedPreferences.getInstance();
    final text = prefs.getString(_kBusinesses);
    if (text == null) return null;
    final decoded = jsonDecode(text) as List<dynamic>;
    return decoded.map((e) => Map<String, dynamic>.from(e)).toList();
  }
}

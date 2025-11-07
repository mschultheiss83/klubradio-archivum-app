// lib/services/api_cache_service.dart
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ApiCacheService {
  ApiCacheService();

  static const String _cachePrefix = 'api_cache_';

  Future<void> save(String key, dynamic data, {Duration? expiry}) async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData = jsonEncode(data);
    final int expiryTime = expiry != null
        ? DateTime.now().add(expiry).millisecondsSinceEpoch
        : -1; // -1 for no expiry

    final Map<String, dynamic> cacheEntry = {
      'data': encodedData,
      'expiry': expiryTime,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    };

    await prefs.setString('$_cachePrefix$key', jsonEncode(cacheEntry));
  }

  Future<dynamic> get(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final String? rawCacheEntry = prefs.getString('$_cachePrefix$key');

    if (rawCacheEntry == null) {
      return null;
    }

    final Map<String, dynamic> cacheEntry = jsonDecode(rawCacheEntry);
    final int expiryTime = cacheEntry['expiry'];

    if (expiryTime != -1 && DateTime.now().millisecondsSinceEpoch > expiryTime) {
      // Cache expired, remove it
      await prefs.remove('$_cachePrefix$key');
      return null;
    }

    return jsonDecode(cacheEntry['data']);
  }

  Future<void> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('$_cachePrefix$key');
  }

  Future<bool> isCached(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('$_cachePrefix$key');
  }

  Future<bool> isExpired(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final String? rawCacheEntry = prefs.getString('$_cachePrefix$key');

    if (rawCacheEntry == null) {
      return true; // Not cached, so considered expired
    }

    final Map<String, dynamic> cacheEntry = jsonDecode(rawCacheEntry);
    final int expiryTime = cacheEntry['expiry'];

    return expiryTime != -1 && DateTime.now().millisecondsSinceEpoch > expiryTime;
  }
}

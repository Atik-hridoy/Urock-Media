import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

/// Local Storage Service
/// Handles all local storage operations using SharedPreferences
class StorageService {
  static SharedPreferences? _prefs;

  /// Initialize storage service
  static Future<void> init() async {
    try {
      _prefs = await SharedPreferences.getInstance();
    } catch (e) {
      // If SharedPreferences fails to initialize, log the error but don't crash
      // The app will work without persistent storage (no auto-login)
      print('Warning: SharedPreferences failed to initialize: $e');
      print('App will continue without persistent storage');
      _prefs = null;
    }
  }

  /// Get SharedPreferences instance
  static SharedPreferences? get prefs {
    return _prefs;
  }

  /// Check if storage is initialized
  static bool get isInitialized {
    return _prefs != null;
  }

  // ==================== Token Management ====================

  /// Save authentication token
  static Future<bool> saveToken(String token) async {
    if (_prefs == null) return false;
    return await _prefs!.setString('auth_token', token);
  }

  /// Get authentication token
  static String? getToken() {
    if (_prefs == null) return null;
    return _prefs!.getString('auth_token');
  }

  /// Remove authentication token
  static Future<bool> removeToken() async {
    if (_prefs == null) return false;
    return await _prefs!.remove('auth_token');
  }

  /// Check if user is logged in
  static bool isLoggedIn() {
    if (_prefs == null) return false;
    final token = getToken();
    return token != null && token.isNotEmpty;
  }

  // ==================== User Data Management ====================

  /// Save user data
  static Future<bool> saveUserData(Map<String, dynamic> userData) async {
    if (_prefs == null) return false;
    final userJson = jsonEncode(userData);
    return await _prefs!.setString('user_data', userJson);
  }

  /// Get user data
  static Map<String, dynamic>? getUserData() {
    if (_prefs == null) return null;
    final userJson = _prefs!.getString('user_data');
    if (userJson != null) {
      return jsonDecode(userJson) as Map<String, dynamic>;
    }
    return null;
  }

  /// Remove user data
  static Future<bool> removeUserData() async {
    if (_prefs == null) return false;
    return await _prefs!.remove('user_data');
  }

  // ==================== General Storage ====================

  /// Save string value
  static Future<bool> saveString(String key, String value) async {
    if (_prefs == null) return false;
    return await _prefs!.setString(key, value);
  }

  /// Get string value
  static String? getString(String key) {
    if (_prefs == null) return null;
    return _prefs!.getString(key);
  }

  /// Save int value
  static Future<bool> saveInt(String key, int value) async {
    if (_prefs == null) return false;
    return await _prefs!.setInt(key, value);
  }

  /// Get int value
  static int? getInt(String key) {
    if (_prefs == null) return null;
    return _prefs!.getInt(key);
  }

  /// Save bool value
  static Future<bool> saveBool(String key, bool value) async {
    if (_prefs == null) return false;
    return await _prefs!.setBool(key, value);
  }

  /// Get bool value
  static bool? getBool(String key) {
    if (_prefs == null) return null;
    return _prefs!.getBool(key);
  }

  /// Save double value
  static Future<bool> saveDouble(String key, double value) async {
    if (_prefs == null) return false;
    return await _prefs!.setDouble(key, value);
  }

  /// Get double value
  static double? getDouble(String key) {
    if (_prefs == null) return null;
    return _prefs!.getDouble(key);
  }

  /// Save list of strings
  static Future<bool> saveStringList(String key, List<String> value) async {
    if (_prefs == null) return false;
    return await _prefs!.setStringList(key, value);
  }

  /// Get list of strings
  static List<String>? getStringList(String key) {
    if (_prefs == null) return null;
    return _prefs!.getStringList(key);
  }

  /// Remove specific key
  static Future<bool> remove(String key) async {
    if (_prefs == null) return false;
    return await _prefs!.remove(key);
  }

  /// Clear all data
  static Future<bool> clearAll() async {
    if (_prefs == null) return false;
    return await _prefs!.clear();
  }

  /// Check if key exists
  static bool containsKey(String key) {
    if (_prefs == null) return false;
    return _prefs!.containsKey(key);
  }

  /// Logout - Clear all auth data
  static Future<void> logout() async {
    await removeToken();
    await removeUserData();
  }
}

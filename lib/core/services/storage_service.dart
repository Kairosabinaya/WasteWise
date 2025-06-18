import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_constants.dart';

class StorageService {
  final SharedPreferences _prefs;

  StorageService(this._prefs);

  // String operations
  Future<bool> setString(String key, String value) async {
    return await _prefs.setString(key, value);
  }

  String? getString(String key) {
    return _prefs.getString(key);
  }

  // Integer operations
  Future<bool> setInt(String key, int value) async {
    return await _prefs.setInt(key, value);
  }

  int? getInt(String key) {
    return _prefs.getInt(key);
  }

  // Boolean operations
  Future<bool> setBool(String key, bool value) async {
    return await _prefs.setBool(key, value);
  }

  bool? getBool(String key) {
    return _prefs.getBool(key);
  }

  // Double operations
  Future<bool> setDouble(String key, double value) async {
    return await _prefs.setDouble(key, value);
  }

  double? getDouble(String key) {
    return _prefs.getDouble(key);
  }

  // List operations
  Future<bool> setStringList(String key, List<String> value) async {
    return await _prefs.setStringList(key, value);
  }

  List<String>? getStringList(String key) {
    return _prefs.getStringList(key);
  }

  // JSON operations
  Future<bool> setJson(String key, Map<String, dynamic> value) async {
    final jsonString = jsonEncode(value);
    return await _prefs.setString(key, jsonString);
  }

  Map<String, dynamic>? getJson(String key) {
    final jsonString = _prefs.getString(key);
    if (jsonString == null) return null;
    try {
      return jsonDecode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      return null;
    }
  }

  // Remove operations
  Future<bool> remove(String key) async {
    return await _prefs.remove(key);
  }

  Future<bool> clear() async {
    return await _prefs.clear();
  }

  // Check if key exists
  bool containsKey(String key) {
    return _prefs.containsKey(key);
  }

  // App specific methods
  Future<bool> saveUserToken(String token) async {
    return await setString(AppConstants.userTokenKey, token);
  }

  String? getUserToken() {
    return getString(AppConstants.userTokenKey);
  }

  Future<bool> saveUserData(Map<String, dynamic> userData) async {
    return await setJson(AppConstants.userDataKey, userData);
  }

  Map<String, dynamic>? getUserData() {
    return getJson(AppConstants.userDataKey);
  }

  Future<bool> saveUserPoints(int points) async {
    return await setInt(AppConstants.pointsKey, points);
  }

  int getUserPoints() {
    return getInt(AppConstants.pointsKey) ?? 0;
  }

  Future<bool> setOnboardingCompleted(bool completed) async {
    return await setBool(AppConstants.onboardingCompletedKey, completed);
  }

  bool isOnboardingCompleted() {
    return getBool(AppConstants.onboardingCompletedKey) ?? false;
  }

  Future<bool> saveAchievements(List<String> achievements) async {
    return await setStringList(AppConstants.achievementsKey, achievements);
  }

  List<String> getAchievements() {
    return getStringList(AppConstants.achievementsKey) ?? [];
  }

  // Clear user data on logout
  Future<bool> clearUserData() async {
    final futures = [
      remove(AppConstants.userTokenKey),
      remove(AppConstants.userDataKey),
      remove(AppConstants.pointsKey),
      remove(AppConstants.achievementsKey),
    ];

    final results = await Future.wait(futures);
    return results.every((result) => result);
  }
}

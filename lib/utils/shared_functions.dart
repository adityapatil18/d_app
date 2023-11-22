import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const _keyUserId = 'userId';

  static const String isLoggedInKey = 'isLoggedIn';

  static Future<void> saveLoginState(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(isLoggedInKey, isLoggedIn);
  }

  static Future<bool> getLoginState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isLoggedInKey) ?? false;
  }

  // Save user ID to SharedPreferences
  static Future<void> saveUserId(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUserId, userId);
  }

  // Get user ID from SharedPreferences
  static Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUserId);
  }
}

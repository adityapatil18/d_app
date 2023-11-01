import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const _keyUserId = 'userId';

  // Save user ID to SharedPreferences
  static Future<void> saveUserId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUserId, userId);
  }

  // Get user ID from SharedPreferences
  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUserId);
  }
}

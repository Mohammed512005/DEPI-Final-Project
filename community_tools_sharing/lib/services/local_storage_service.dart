import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const _keyOnboardingShown = 'onboarding_shown';
  static const _keyLoggedIn = 'logged_in';

  /// ✅ Mark onboarding as shown
  static Future<void> setOnboardingShown(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyOnboardingShown, value);
  }

  /// ✅ Check if onboarding was shown
  static Future<bool> isOnboardingShown() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyOnboardingShown) ?? false;
  }

  /// ✅ Save login state
  static Future<void> setLoggedIn(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyLoggedIn, value);
  }

  /// ✅ Check login state
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyLoggedIn) ?? false;
  }

  /// Optional: clear all data (for logout or testing)
  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const String _accessTokenKey = 'token';
  static const String _selectedRoleKey = 'selectedRole';
  static const String _categoriesKey = "categories";
  static const String _isWelcomeDialogShownKey =
      'isDriverVerificationDialogShown';

  static const String _selectedGameKey = 'selected_game';

  static Future<void> saveCategories(
    List<Map<String, String>> categories,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final categoriesJson = jsonEncode(categories);
    await prefs.setString(_categoriesKey, categoriesJson);
  }

  static Future<List<Map<String, String>>> getCategories() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final categoriesJson = prefs.getString(_categoriesKey);
    if (categoriesJson != null) {
      return List<Map<String, String>>.from(jsonDecode(categoriesJson));
    }
    return [];
  }

  static Future<void> saveTokenAndRole(
    String token,
    String role,
    var userId,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_accessTokenKey, token);
    await prefs.setString(_selectedRoleKey, role);
    await prefs.setString('userId', userId.toString());
    await prefs.setBool('isLogin', true);
  }

  static Future<void> isSubscribed(dynamic isSubscribed) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (isSubscribed != null) {
      await prefs.setString('isSubscribed', isSubscribed.toString());
    }
  }

  static Future<String?> getAccessToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_accessTokenKey);
  }

  static Future<String?> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId');
  }

  static Future<String?> getSubscriptionStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('isSubscribed');
  }

  static Future<void> clearAllData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_accessTokenKey);
    await prefs.remove(_selectedRoleKey);
    await prefs.remove('isLogin');
  }

  static Future<String?> getSelectedRole() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_selectedRoleKey);
  }

  static Future<bool?> checkLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isLogin") ?? false;
  }

  static Future<void> setWelcomeDialogShown(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isWelcomeDialogShownKey, value);
  }

  static Future<bool> isWelcomeDialogShown() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isWelcomeDialogShownKey) ?? false;
  }

  static const String _showOnboardKey = 'showOnboard';

  static Future<void> setShowOnboard(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_showOnboardKey, value);
  }

  static Future<bool> getShowOnboard() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_showOnboardKey) ?? false;
  }

  static Future<void> saveSelectedGame(String game) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_selectedGameKey, game);
  }

  static Future<String?> getSelectedGame() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_selectedGameKey);
  }

  static Future<void> saveEmailPrivacy(bool isPrivate) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isEmailPrivate', isPrivate);
  }

  static Future<bool> getEmailPrivacy() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isEmailPrivate') ?? false;
  }

  static Future<void> saveTrackingConsent(bool consent) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isTrackingConsent', consent);
  }

  static Future<bool> getTrackingConsent() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isTrackingConsent') ?? false;
  }
}

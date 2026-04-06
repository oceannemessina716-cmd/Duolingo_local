import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  final SharedPreferences prefs;

  static const String _keyNativeLang = 'native_lang';
  static const String _keyTargetLang = 'target_lang';
  static const String _keyOnboardingDone = 'onboarding_complete';

  SettingsService(this.prefs);

  // Get the system language as a default (e.g., 'fr' or 'en')
  String get systemLanguage => Platform.localeName.split('_')[0];

  // Native Language Management
  String get nativeLanguage => prefs.getString(_keyNativeLang) ?? systemLanguage;

  Future<void> setNativeLanguage(String langCode) async {
    await prefs.setString(_keyNativeLang, langCode);
  }

  Future<void> setTargetLanguage(String lang) async => await prefs.setString(_keyTargetLang, lang);

  String? get targetLanguage => prefs.getString(_keyTargetLang);

  // Onboarding Management
  bool get isOnboardingComplete => prefs.getBool(_keyOnboardingDone) ?? false;

  Future<void> completeOnboarding() async {
    await prefs.setBool(_keyOnboardingDone, true);
  }
}

import 'package:flutter/material.dart';

enum AppThemeMode { light, dark, system }

extension AppThemeModeX on AppThemeMode {
  ThemeMode get materialThemeMode => switch (this) {
        AppThemeMode.light => ThemeMode.light,
        AppThemeMode.dark => ThemeMode.dark,
        AppThemeMode.system => ThemeMode.system,
      };

  String get prefsValue => name;

  static AppThemeMode fromPrefs(String? value) =>
      AppThemeMode.values.firstWhere((e) => e.name == value, orElse: () => AppThemeMode.light);
}

class AppSettings {
  final AppThemeMode themeMode;
  final bool notificationsEnabled;
  final bool autoSync;
  final bool darkMap;
  final String languageCode; // 'ru' | 'en' | 'kk'

  const AppSettings({
    required this.themeMode,
    required this.notificationsEnabled,
    required this.autoSync,
    required this.darkMap,
    required this.languageCode,
  });

  static const defaults = AppSettings(
    themeMode: AppThemeMode.light,
    notificationsEnabled: true,
    autoSync: true,
    darkMap: false,
    languageCode: 'ru',
  );

  AppSettings copyWith({
    AppThemeMode? themeMode,
    bool? notificationsEnabled,
    bool? autoSync,
    bool? darkMap,
    String? languageCode,
  }) {
    return AppSettings(
      themeMode: themeMode ?? this.themeMode,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      autoSync: autoSync ?? this.autoSync,
      darkMap: darkMap ?? this.darkMap,
      languageCode: languageCode ?? this.languageCode,
    );
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/app_settings.dart';

/// Overridden in main() with the resolved SharedPreferences instance.
final sharedPreferencesProvider = Provider<SharedPreferences>(
  (ref) => throw UnimplementedError('sharedPreferencesProvider must be overridden in main()'),
);

const _kTheme = 'settings.themeMode';
const _kNotif = 'settings.notificationsEnabled';
const _kSync = 'settings.autoSync';
const _kDarkMap = 'settings.darkMap';
const _kLang = 'settings.languageCode';

class SettingsController extends StateNotifier<AppSettings> {
  SettingsController(this._prefs) : super(_load(_prefs));
  final SharedPreferences _prefs;

  static AppSettings _load(SharedPreferences p) => AppSettings(
        themeMode: AppThemeModeX.fromPrefs(p.getString(_kTheme)),
        notificationsEnabled: p.getBool(_kNotif) ?? AppSettings.defaults.notificationsEnabled,
        autoSync: p.getBool(_kSync) ?? AppSettings.defaults.autoSync,
        darkMap: p.getBool(_kDarkMap) ?? AppSettings.defaults.darkMap,
        languageCode: p.getString(_kLang) ?? AppSettings.defaults.languageCode,
      );

  Future<void> setThemeMode(AppThemeMode mode) async {
    state = state.copyWith(themeMode: mode);
    await _prefs.setString(_kTheme, mode.prefsValue);
  }

  Future<void> setNotificationsEnabled(bool value) async {
    state = state.copyWith(notificationsEnabled: value);
    await _prefs.setBool(_kNotif, value);
  }

  Future<void> setAutoSync(bool value) async {
    state = state.copyWith(autoSync: value);
    await _prefs.setBool(_kSync, value);
  }

  Future<void> setDarkMap(bool value) async {
    state = state.copyWith(darkMap: value);
    await _prefs.setBool(_kDarkMap, value);
  }

  Future<void> setLanguageCode(String code) async {
    state = state.copyWith(languageCode: code);
    await _prefs.setString(_kLang, code);
  }
}

final settingsControllerProvider = StateNotifierProvider<SettingsController, AppSettings>(
  (ref) => SettingsController(ref.watch(sharedPreferencesProvider)),
);

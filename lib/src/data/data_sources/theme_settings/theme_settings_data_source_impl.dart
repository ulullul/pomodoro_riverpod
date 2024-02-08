import 'dart:convert';

import 'package:pomodorro/src/data/models/theme_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'theme_settings_data_source.dart';

class ThemeSettingsDataSourceImpl implements ThemeSettingsDataSource {
  static const _themeKey = 'theme';
  final SharedPreferences _sharedPreferences;

  ThemeSettingsDataSourceImpl(this._sharedPreferences);

  @override
  ThemeSettings getTheme() {
    final savedTheme = _sharedPreferences.getString(_themeKey);
    if (savedTheme == null) return ThemeSettings();
    final json = jsonDecode(savedTheme);
    return ThemeSettings.fromJson(json);
  }

  @override
  Future<void> setTheme(ThemeSettings themeSettings) async {
    await _sharedPreferences.setString(
      _themeKey,
      jsonEncode(themeSettings.toJson()),
    );
  }
}

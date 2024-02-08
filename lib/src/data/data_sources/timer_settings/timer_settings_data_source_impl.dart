import 'dart:convert';

import 'package:pomodorro/src/data/models/timer_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'timer_settings_data_source.dart';

class TimerSettingsDataSourceImpl implements TimerSettingsDataSource {
  static const _key = 'timer_settings';
  final SharedPreferences _sharedPreferences;

  TimerSettingsDataSourceImpl(this._sharedPreferences);

  @override
  TimerSettings getTimerSettings() {
    final timerSettings = _sharedPreferences.getString(_key);
    if (timerSettings == null) return TimerSettings();
    final json = jsonDecode(timerSettings);
    return TimerSettings.fromJson(json);
  }

  @override
  Future<void> setTimerSettings(TimerSettings timerSettings) async {
    await _sharedPreferences.setString(
      _key,
      jsonEncode(timerSettings.toJson()),
    );
  }
}

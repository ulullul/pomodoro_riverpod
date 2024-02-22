import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodorro/src/providers/shared_preferences_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'timer_settings_data_source.dart';
import 'timer_settings_data_source_impl.dart';

part 'timer_settings_data_source_provider.g.dart';

@riverpod
TimerSettingsDataSource timerSettingsDataSource(TimerSettingsDataSourceRef ref) {
  return TimerSettingsDataSourceImpl(ref.read(sharedPreferencesProvider));
}
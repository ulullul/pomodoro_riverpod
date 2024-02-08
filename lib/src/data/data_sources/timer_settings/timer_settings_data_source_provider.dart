import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodorro/src/providers/shared_preferences_provider.dart';

import 'timer_settings_data_source.dart';
import 'timer_settings_data_source_impl.dart';

final timerSettingsDataSourceProvider = Provider<TimerSettingsDataSource>(
  (ref) => TimerSettingsDataSourceImpl(ref.read(sharedPreferencesProvider)),
);
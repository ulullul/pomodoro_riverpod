import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodorro/src/providers/shared_preferences_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'theme_settings_data_source.dart';
import 'theme_settings_data_source_impl.dart';

part 'theme_settings_data_source_provider.g.dart';

@riverpod
ThemeSettingsDataSource themeSettingsDataSource(ThemeSettingsDataSourceRef ref) {
  return ThemeSettingsDataSourceImpl(ref.read(sharedPreferencesProvider));
}

/*
final themeSettingsDataSourceProvider = Provider<ThemeSettingsDataSource>(
  (ref) => ThemeSettingsDataSourceImpl(ref.read(sharedPreferencesProvider)),
);
*/

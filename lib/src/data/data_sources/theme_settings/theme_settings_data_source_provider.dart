import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodorro/src/providers/shared_preferences_provider.dart';

import 'theme_settings_data_source.dart';
import 'theme_settings_data_source_impl.dart';

final themeSettingsDataSourceProvider = Provider<ThemeSettingsDataSource>(
  (ref) => ThemeSettingsDataSourceImpl(ref.read(sharedPreferencesProvider)),
);

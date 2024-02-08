import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodorro/src/data/data_sources/theme_settings/theme_settings_data_source.dart';
import 'package:pomodorro/src/data/data_sources/theme_settings/theme_settings_data_source_impl.dart';
import 'package:pomodorro/src/data/models/theme_settings.dart';
import 'package:pomodorro/src/providers/shared_preferences_provider.dart';

final themeSettingsProvider =
    NotifierProvider<ThemeSettingsNotifier, ThemeSettings>(
  () => ThemeSettingsNotifier(),
);

class ThemeSettingsNotifier extends Notifier<ThemeSettings> {
  late final ThemeSettingsDataSource themeDataSource;

  @override
  ThemeSettings build() {
    final prefs = ref.read(sharedPreferencesProvider);
    themeDataSource = ThemeSettingsDataSourceImpl(prefs);
    return themeDataSource.getTheme();
  }

  void setTheme(ThemeSettings themeSettings) {
    if (themeSettings == state) return;
    themeDataSource.setTheme(themeSettings);
    state = themeSettings;
  }
}

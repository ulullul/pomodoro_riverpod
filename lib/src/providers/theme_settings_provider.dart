import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodorro/src/data/data_sources/theme_settings/theme_settings_data_source.dart';
import 'package:pomodorro/src/data/data_sources/theme_settings/theme_settings_data_source_provider.dart';
import 'package:pomodorro/src/data/models/theme_settings.dart';

final themeSettingsProvider =
    NotifierProvider<ThemeSettingsNotifier, ThemeSettings>(
  () => ThemeSettingsNotifier(),
);

class ThemeSettingsNotifier extends Notifier<ThemeSettings> {
  late final ThemeSettingsDataSource themeDataSource =
      ref.read(themeSettingsDataSourceProvider);

  @override
  ThemeSettings build() {
    return themeDataSource.getTheme();
  }

  void setTheme(ThemeSettings themeSettings) {
    if (themeSettings == state) return;
    themeDataSource.setTheme(themeSettings);
    state = themeSettings;
  }
}

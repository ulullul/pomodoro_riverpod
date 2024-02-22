import 'package:pomodorro/src/data/data_sources/theme_settings/theme_settings_data_source.dart';
import 'package:pomodorro/src/data/data_sources/theme_settings/theme_settings_data_source_provider.dart';
import 'package:pomodorro/src/data/models/theme_settings.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_settings_provider.g.dart';

@riverpod
class ThemeSettingsNotifier extends _$ThemeSettingsNotifier {
  late final ThemeSettingsDataSource themeDataSource =
      ref.read(themeSettingsDataSourceProvider);

  @override
  ThemeSettings build() => themeDataSource.getTheme();

  void setTheme(ThemeSettings themeSettings) {
    if (themeSettings == state) return;
    themeDataSource.setTheme(themeSettings);
    state = themeSettings;
  }
}

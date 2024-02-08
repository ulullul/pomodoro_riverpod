import 'package:pomodorro/src/data/models/theme_settings.dart';

abstract class ThemeSettingsDataSource {
  ThemeSettings getTheme();

  Future<void> setTheme(ThemeSettings themeSettings);
}

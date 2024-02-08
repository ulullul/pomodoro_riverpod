import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:pomodorro/shared/theme/theme.dart';
import 'package:pomodorro/src/data/models/theme_settings.dart';
import 'package:pomodorro/src/data/models/timer_settings.dart';
import 'package:pomodorro/src/providers/shared_preferences_provider.dart';
import 'package:pomodorro/src/providers/theme_settings_provider.dart';
import 'package:pomodorro/src/providers/timer_settings_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

ProviderContainer createContainer({
  ProviderContainer? parent,
  List<Override> overrides = const [],
  List<ProviderObserver>? observers,
}) {
  final container = ProviderContainer(
    parent: parent,
    overrides: overrides,
    observers: observers,
  );

  addTearDown(container.dispose);

  return container;
}

void main() {
  late final ProviderContainer container;

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    final prefsInstance = await SharedPreferences.getInstance();

    container = createContainer(overrides: [
      sharedPreferencesProvider.overrideWithValue(prefsInstance),
    ]);
  });

  group('Settings tests', () {
    test('Default timer settings are correct', () async {
      final timerSettings = container.read(timerSettingsProvider);

      expect(
        timerSettings,
        equals(
          TimerSettings(
            pomodoro: 1500,
            shortBreak: 300,
            longBreak: 900,
          ),
        ),
      );
    });

    test('Default theme settings are correct', () async {
      final themeSettings = container.read(themeSettingsProvider);

      expect(
        themeSettings,
        equals(
          ThemeSettings(
            accentColor: AppColors.red,
            appFontFamily: AppFontFamily.spaceMono,
          ),
        ),
      );
    });
  });
}

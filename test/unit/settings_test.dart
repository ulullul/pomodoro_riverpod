import 'dart:convert';

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
      final timerSettings = container.read(timerSettingsNotifierProvider);

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
      final themeSettings = container.read(themeSettingsNotifierProvider);

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

  test('Settings persist after app restart', () async {
    final timerSettings = TimerSettings(
      pomodoro: 100,
      shortBreak: 100,
      longBreak: 100,
    );

    final themeSettings = ThemeSettings(
      accentColor: AppColors.aqua,
      appFontFamily: AppFontFamily.kumbhSans,
    );

    container
        .read(timerSettingsNotifierProvider.notifier)
        .setTimerSettings(timerSettings);
    container.read(themeSettingsNotifierProvider.notifier).setTheme(themeSettings);

    // Simulate app restart by creating a new container
    SharedPreferences.setMockInitialValues({
      'theme': jsonEncode(themeSettings.toJson()),
      'timer_settings': jsonEncode(timerSettings.toJson()),
    });
    final newContainer = createContainer(overrides: [
      sharedPreferencesProvider
          .overrideWithValue(await SharedPreferences.getInstance()),
    ]);

    expect(
      newContainer.read(timerSettingsNotifierProvider),
      equals(timerSettings),
    );
    expect(
      newContainer.read(themeSettingsNotifierProvider),
      equals(themeSettings),
    );
  });
}

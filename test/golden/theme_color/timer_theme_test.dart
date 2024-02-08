import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pomodorro/src/pages/home/widgets/home_segmented_button.dart';
import 'package:pomodorro/src/pages/home/widgets/timer/home_timer.dart';
import 'package:pomodorro/src/providers/shared_preferences_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ColorsBytes {
  static const red = 4294471792;
  static const aqua = 4285592568;
  static const purple = 4292379128;
}

void main() {
  group('Theme tests', () {
    testWidgets('Red theme (default) displayed correctly for the timer',
        (tester) async {
      SharedPreferences.setMockInitialValues({});
      final prefsInstance = await SharedPreferences.getInstance();

      const widget = HomeTimer();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(prefsInstance),
          ],
          child: const MaterialApp(
            home: widget,
          ),
        ),
      );

      await tester.pumpAndSettle();

      await expectLater(
        find.byType(HomeTimer),
        matchesGoldenFile('red_theme_timer.png'),
      );
    });

    testWidgets('Aqua theme displayed correctly for timer', (tester) async {
      SharedPreferences.setMockInitialValues({
        'theme':
            '{"accentColor":${ColorsBytes.aqua},"appFontFamily":"Space Mono"}'
      });
      final prefsInstance = await SharedPreferences.getInstance();

      const widget = HomeTimer();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(prefsInstance),
          ],
          child: const MaterialApp(
            home: widget,
          ),
        ),
      );

      await tester.pumpAndSettle();

      await expectLater(
        find.byType(HomeTimer),
        matchesGoldenFile('aqua_theme_timer.png'),
      );
    });

    testWidgets('Purple theme displayed correctly for the timer',
        (tester) async {
      SharedPreferences.setMockInitialValues({
        'theme':
            '{"accentColor":${ColorsBytes.purple},"appFontFamily":"Space Mono"}'
      });
      final prefsInstance = await SharedPreferences.getInstance();

      const widget = HomeTimer();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(prefsInstance),
          ],
          child: const MaterialApp(
            home: widget,
          ),
        ),
      );

      await tester.pumpAndSettle();

      await expectLater(
        find.byType(HomeTimer),
        matchesGoldenFile('purple_theme_timer.png'),
      );
    });

    testWidgets('Red theme (default) displayed correctly for segmented button',
        (tester) async {
      SharedPreferences.setMockInitialValues({});
      final prefsInstance = await SharedPreferences.getInstance();

      const widget = HomeSegmentedButton();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(prefsInstance),
          ],
          child: const MaterialApp(
            home: widget,
          ),
        ),
      );

      await tester.pumpAndSettle();

      await expectLater(
        find.byType(HomeSegmentedButton),
        matchesGoldenFile('red_theme_segmented_button.png'),
      );
    });

    testWidgets('Aqua theme displayed correctly for segmented button',
        (tester) async {
      SharedPreferences.setMockInitialValues({
        'theme':
            '{"accentColor":${ColorsBytes.aqua},"appFontFamily":"Space Mono"}'
      });
      final prefsInstance = await SharedPreferences.getInstance();

      const widget = HomeSegmentedButton();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(prefsInstance),
          ],
          child: const MaterialApp(
            home: widget,
          ),
        ),
      );

      await tester.pumpAndSettle();

      await expectLater(
        find.byType(HomeSegmentedButton),
        matchesGoldenFile('aqua_theme_segmented_button.png'),
      );
    });

    testWidgets('Purple theme displayed correctly for segmented button',
        (tester) async {
      SharedPreferences.setMockInitialValues({
        'theme':
            '{"accentColor":${ColorsBytes.purple},"appFontFamily":"Space Mono"}'
      });
      final prefsInstance = await SharedPreferences.getInstance();

      const widget = HomeSegmentedButton();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(prefsInstance),
          ],
          child: const MaterialApp(
            home: widget,
          ),
        ),
      );

      await tester.pumpAndSettle();

      await expectLater(
        find.byType(HomeSegmentedButton),
        matchesGoldenFile('purple_theme_segmented_button.png'),
      );
    });
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:pomodorro/shared/theme/font_family.dart';
import 'package:pomodorro/src/pages/home/widgets/home_segmented_button.dart';
import 'package:pomodorro/src/pages/home/widgets/timer/home_timer.dart';
import 'package:pomodorro/src/providers/shared_preferences_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ColorsBytes {
  static const red = 4294471792;
}

void main() {
  group('Theme tests', () {
    testWidgets('Khumb Sans font is displayed correctly for the timer', (tester) async {
      await loadAppFonts();

      SharedPreferences.setMockInitialValues({
        'theme': '{"accentColor":${ColorsBytes.red},"appFontFamily":"${AppFontFamily.kumbhSans.name}"}'
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
        matchesGoldenFile('kumbh_sans_timer.png'),
      );
    });

    testWidgets('Space Mono font is displayed correctly for the timer', (tester) async {
      await loadAppFonts();

      SharedPreferences.setMockInitialValues({
        'theme': '{"accentColor":${ColorsBytes.red},"appFontFamily":"${AppFontFamily.spaceMono.name}"}'
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
        matchesGoldenFile('space_mono_timer.png'),
      );
    });

    testWidgets('Robot Slab font is displayed correctly for the timer', (tester) async {
      await loadAppFonts();

      SharedPreferences.setMockInitialValues({
        'theme': '{"accentColor":${ColorsBytes.red},"appFontFamily":"${AppFontFamily.robotoSlab.name}"}'
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
        matchesGoldenFile('robot_slab_timer.png'),
      );
    });

    testWidgets('Khumb Sans font is displayed correctly for segmented button', (tester) async {
      await loadAppFonts();

      SharedPreferences.setMockInitialValues({
        'theme': '{"accentColor":${ColorsBytes.red},"appFontFamily":"${AppFontFamily.kumbhSans.name}"}'
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
        matchesGoldenFile('kumbh_sans_segmented_button.png'),
      );
    });

    testWidgets('Space Mono font is displayed correctly for segmented button', (tester) async {
      await loadAppFonts();

      SharedPreferences.setMockInitialValues({
        'theme': '{"accentColor":${ColorsBytes.red},"appFontFamily":"${AppFontFamily.spaceMono.name}"}'
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
        matchesGoldenFile('space_mono_segmented_button.png'),
      );
    });

    testWidgets('Robot Slab font is displayed correctly for segmented button', (tester) async {
      await loadAppFonts();

      SharedPreferences.setMockInitialValues({
        'theme': '{"accentColor":${ColorsBytes.red},"appFontFamily":"${AppFontFamily.robotoSlab.name}"}'
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
        matchesGoldenFile('robot_slab_segmented_button.png'),
      );
    });
  });
}

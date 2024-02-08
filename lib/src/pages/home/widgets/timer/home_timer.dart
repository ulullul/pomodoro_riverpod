import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodorro/shared/extensions/context_extension.dart';
import 'package:pomodorro/shared/theme/theme.dart';
import 'package:pomodorro/src/pages/home/providers/formatted_timer_provider.dart';
import 'package:pomodorro/src/pages/home/providers/percentage_timer_provider.dart';
import 'package:pomodorro/src/providers/theme_settings_provider.dart';
import 'package:pomodorro/src/providers/timer/timer_notifier.dart';

import 'timer_status_button.dart';

class HomeTimer extends ConsumerWidget {
  const HomeTimer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeSettingsProvider);
    final formattedTime = ref.watch(formattedTimerProvider);
    final timePercentage = ref.watch(percentageTimerProvider);

    return Material(
      color: Colors.transparent,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: () => ref.read(timerProvider.notifier).toggleTimer(),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned.fill(
              child: CircularProgressIndicator(
                value: timePercentage,
                strokeWidth: 8,
                color: theme.accentColor,
                strokeCap: StrokeCap.round,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  formattedTime,
                  style: TextStyle(
                    fontFamily: theme.appFontFamily.name,
                    fontWeight: FontWeight.values.firstWhere(
                      (element) => element.value == theme.appFontFamily.weight,
                    ),
                    fontSize: context.isMobile ? 80 : 100,
                    color: AppColors.white,
                    letterSpacing: theme.appFontFamily.letterSpacing,
                  ),
                ),
                const TimerStatusButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

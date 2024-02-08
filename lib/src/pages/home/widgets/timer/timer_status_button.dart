import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodorro/shared/const/timer_state.dart';
import 'package:pomodorro/shared/extensions/context_extension.dart';
import 'package:pomodorro/shared/theme/theme.dart';
import 'package:pomodorro/src/providers/theme_settings_provider.dart';
import 'package:pomodorro/src/providers/timer/timer_notifier.dart';

class TimerStatusButton extends ConsumerWidget {
  const TimerStatusButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeSettingsProvider);
    final timerState =
        ref.watch(timerProvider.select((value) => value.timerState));

    final buttonText = switch (timerState) {
      TimerStateEnum.initial ||
      TimerStateEnum.finished =>
        'start',
      TimerStateEnum.running => 'pause',
      TimerStateEnum.paused => 'resume',
    }.toUpperCase();

    return Text(
      buttonText.toUpperCase(),
      style: TextStyle(
        color: AppColors.lightBlue,
        fontWeight: FontWeight.bold,
        fontSize: context.isMobile ? 14 : 16,
        letterSpacing: 13,
        fontFamily: theme.appFontFamily.name,
      ),
    );
  }
}

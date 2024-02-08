import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodorro/shared/const/pomodoro_state.dart';
import 'package:pomodorro/shared/extensions/int_extension.dart';
import 'package:pomodorro/src/providers/app_action_provider.dart';
import 'package:pomodorro/src/providers/timer/timer_notifier.dart';
import 'package:pomodorro/src/providers/timer_settings_provider.dart';

final percentageTimerProvider = Provider.autoDispose<double>((ref) {
  final currentTime = ref.watch(timerProvider).secondsLeft;
  final timerSettings = ref.watch(timerSettingsProvider);

  final totalTime = switch (ref.read(pomodoroStateProvider)) {
    PomodoroState.pomodoro => timerSettings.pomodoro,
    PomodoroState.shortBreak => timerSettings.shortBreak,
    PomodoroState.longBreak => timerSettings.longBreak,
  }
      .toSeconds;

  return 1 - (currentTime / totalTime);
});

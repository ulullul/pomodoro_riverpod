import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodorro/shared/const/pomodoro_state.dart';
import 'package:pomodorro/src/providers/pomodoro_state_provider.dart';
import 'package:pomodorro/src/providers/timer/timer_notifier.dart';
import 'package:pomodorro/src/providers/timer_settings_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'percentage_timer_provider.g.dart';

/*
final percentageTimerNotifierProvider = Provider.autoDispose<double>((ref) {
  final currentTime = ref.watch(timerNotifierProvider).secondsLeft;
  final timerSettings = ref.watch(timerSettingsNotifierProvider);

  final totalTime = switch (ref.read(pomodoroStateNotifierProvider)) {
    PomodoroState.pomodoro => timerSettings.pomodoro,
    PomodoroState.shortBreak => timerSettings.shortBreak,
    PomodoroState.longBreak => timerSettings.longBreak,
  };

  return currentTime / totalTime;
});
*/

@riverpod
class PercentageTimer extends _$PercentageTimer {
  @override
  double build() {
    final currentTime = ref.watch(timerNotifierProvider).secondsLeft;
    final timerSettings = ref.watch(timerSettingsNotifierProvider);

    final totalTime = switch (ref.read(pomodoroStateNotifierProvider)) {
      PomodoroState.pomodoro => timerSettings.pomodoro,
      PomodoroState.shortBreak => timerSettings.shortBreak,
      PomodoroState.longBreak => timerSettings.longBreak,
    };

    return currentTime / totalTime;
  }
}

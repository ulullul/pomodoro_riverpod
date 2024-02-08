import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodorro/shared/const/app_constants.dart';
import 'package:pomodorro/shared/const/pomodoro_state.dart';
import 'package:pomodorro/shared/const/timer_state.dart';
import 'package:pomodorro/src/data/data_sources/timer_settings/timer_settings_data_source_provider.dart';
import 'package:pomodorro/src/providers/pomodoro_state_provider.dart';
import 'package:pomodorro/src/providers/timer_settings_provider.dart';

import 'timer_state.dart';

final timerProvider = NotifierProvider.autoDispose<TimerNotifier, TimerState>(
  () => TimerNotifier(),
);

class TimerNotifier extends AutoDisposeNotifier<TimerState> {
  late final timerDataSource = ref.read(timerSettingsDataSourceProvider);
  Timer? _timer;
  int _currentRound = 0;

  @override
  TimerState build() {
    stopActiveTimer();

    final timerSettings = ref.read(timerSettingsProvider);

    final currentAppAction = ref.read(pomodoroStateProvider);

    final timeInSeconds = switch (currentAppAction) {
      PomodoroState.pomodoro => timerSettings.pomodoro,
      PomodoroState.shortBreak => timerSettings.shortBreak,
      PomodoroState.longBreak => timerSettings.longBreak,
    };

    return TimerState(
      secondsLeft: timeInSeconds,
      timerState: TimerStateEnum.initial,
    );
  }

  void toggleTimer() {
    if (_timer != null) {
      stopActiveTimer();
      state = state.copyWith(timerState: TimerStateEnum.paused);
    } else {
      start();
      state = state.copyWith(timerState: TimerStateEnum.running);
    }
  }

  void start() {
    if (state.secondsLeft <= 0) {
      state = build();
    }

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.secondsLeft > 0) {
        state = state.copyWith(secondsLeft: state.secondsLeft - 1);
      } else {
        _handleNextRound();
        _timer?.cancel();
      }
    });
  }

  void stopActiveTimer() {
    _timer?.cancel();
    _timer = null;
  }

  void _handleNextRound() {
    final currentPomodoroState = ref.read(pomodoroStateProvider);
    final pomodoroStateNotifier = ref.read(pomodoroStateProvider.notifier);

    if (currentPomodoroState == PomodoroState.pomodoro &&
        _currentRound != AppConstants.pomodoroRounds) {
      pomodoroStateNotifier.state = PomodoroState.shortBreak;
      _currentRound++;
    } else if (currentPomodoroState == PomodoroState.shortBreak) {
      pomodoroStateNotifier.state = PomodoroState.pomodoro;
    } else if (currentPomodoroState == PomodoroState.pomodoro &&
        _currentRound == AppConstants.pomodoroRounds) {
      pomodoroStateNotifier.state = PomodoroState.longBreak;
      _currentRound++;
    } else if (currentPomodoroState == PomodoroState.longBreak) {
      pomodoroStateNotifier.state = PomodoroState.pomodoro;
      _currentRound = 0;
    }

    state = build();
  }
}

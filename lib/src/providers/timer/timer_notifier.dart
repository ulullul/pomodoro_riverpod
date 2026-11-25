import 'dart:async';
import 'dart:developer';
import 'dart:math' show max;

import 'package:clock/clock.dart';
import 'package:pomodorro/shared/const/app_constants.dart';
import 'package:pomodorro/shared/const/pomodoro_state.dart';
import 'package:pomodorro/shared/const/timer_state.dart';
import 'package:pomodorro/src/data/data_sources/notifications/notifications_data_source_provider.dart';
import 'package:pomodorro/src/data/data_sources/timer_settings/timer_settings_data_source_provider.dart';
import 'package:pomodorro/src/providers/pomodoro_state_provider.dart';
import 'package:pomodorro/src/providers/timer_settings_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'timer_state.dart';

part 'timer_notifier.g.dart';

@riverpod
class TimerNotifier extends _$TimerNotifier {
  late final timerDataSource = ref.read(timerSettingsDataSourceProvider);
  late final notificationsDataSource = ref.read(
    notificationsDataSourceProvider,
  );
  Timer? _timer;
  DateTime? _endsAt;
  int _currentRound = 0;

  @override
  TimerState build() {
    stopActiveTimer();

    final timerSettings = ref.read(timerSettingsNotifierProvider);

    final currentAppAction = ref.read(pomodoroStateNotifierProvider);

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

    // The time left is counted from the moment the round ends, as the timer
    // does not tick while the app is in the background.
    final endsAt = clock.now().add(Duration(seconds: state.secondsLeft));
    _endsAt = endsAt;
    _scheduleNotification(endsAt);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.secondsLeft > 0) {
        state = state.copyWith(secondsLeft: _secondsUntil(endsAt));
      } else {
        // The notification is already shown, it should not be cancelled.
        _endsAt = null;
        _handleNextRound();
        _timer?.cancel();
      }
    });
  }

  void stopActiveTimer() {
    _timer?.cancel();
    _timer = null;

    final endsAt = _endsAt;
    _endsAt = null;
    if (endsAt != null && clock.now().isBefore(endsAt)) {
      _runNotificationAction(notificationsDataSource.cancelRoundFinished);
    }
  }

  int _secondsUntil(DateTime endsAt) {
    final millisecondsLeft = endsAt.difference(clock.now()).inMilliseconds;
    return max(0, (millisecondsLeft / 1000).round());
  }

  void _scheduleNotification(DateTime endsAt) {
    final finishedRound = ref.read(pomodoroStateNotifierProvider);

    _runNotificationAction(() async {
      final isGranted = await notificationsDataSource.requestPermission();
      // The timer could be paused while the permission dialog was shown.
      if (!isGranted || _endsAt != endsAt) return;

      await notificationsDataSource.scheduleRoundFinished(
        finishedRound: finishedRound,
        at: endsAt,
      );
    });
  }

  /// Notifications are optional, the timer has to work if they fail.
  Future<void> _runNotificationAction(Future<void> Function() action) async {
    try {
      await action();
    } catch (error, stackTrace) {
      log('Notification failed', error: error, stackTrace: stackTrace);
    }
  }

  void _handleNextRound() {
    final currentPomodoroState = ref.read(pomodoroStateNotifierProvider);
    final pomodoroStateNotifier = ref.read(
      pomodoroStateNotifierProvider.notifier,
    );

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

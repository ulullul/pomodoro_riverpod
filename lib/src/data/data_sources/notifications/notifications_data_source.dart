import 'package:pomodorro/shared/const/pomodoro_state.dart';

abstract class NotificationsDataSource {
  /// Asks the user for the permission to show notifications.
  Future<bool> requestPermission();

  /// Schedules the notification about the end of [finishedRound] to be shown
  /// at [at], even if the app is in the background by then.
  Future<void> scheduleRoundFinished({
    required PomodoroState finishedRound,
    required DateTime at,
  });

  /// Cancels the notification scheduled with [scheduleRoundFinished].
  Future<void> cancelRoundFinished();
}

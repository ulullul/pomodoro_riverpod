import 'package:pomodorro/shared/const/pomodoro_state.dart';
import 'package:pomodorro/src/data/data_sources/notifications/notifications_data_source.dart';

typedef ScheduledNotification = ({PomodoroState finishedRound, DateTime at});

class FakeNotificationsDataSource implements NotificationsDataSource {
  bool isPermissionGranted;

  ScheduledNotification? scheduled;
  int scheduleCalls = 0;
  int cancelCalls = 0;

  FakeNotificationsDataSource({this.isPermissionGranted = true});

  @override
  Future<bool> requestPermission() async => isPermissionGranted;

  @override
  Future<void> scheduleRoundFinished({
    required PomodoroState finishedRound,
    required DateTime at,
  }) async {
    scheduleCalls++;
    scheduled = (finishedRound: finishedRound, at: at);
  }

  @override
  Future<void> cancelRoundFinished() async {
    cancelCalls++;
    scheduled = null;
  }
}

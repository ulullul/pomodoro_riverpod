import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pomodorro/shared/const/pomodoro_state.dart';
import 'package:timezone/timezone.dart' as tz;

import 'notifications_data_source.dart';

class NotificationsDataSourceImpl implements NotificationsDataSource {
  static const _roundFinishedId = 0;

  static const _initializationSettings = InitializationSettings(
    android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    // Permissions are requested when the timer is started for the first time.
    iOS: DarwinInitializationSettings(
      requestAlertPermission: false,
      requestSoundPermission: false,
      requestBadgePermission: false,
    ),
  );

  static const _notificationDetails = NotificationDetails(
    android: AndroidNotificationDetails(
      'timer',
      'Timer',
      channelDescription: 'Notifies when a pomodoro or a break is finished',
      importance: Importance.high,
      priority: Priority.high,
    ),
  );

  final FlutterLocalNotificationsPlugin _plugin;
  AndroidScheduleMode _androidScheduleMode =
      AndroidScheduleMode.inexactAllowWhileIdle;

  NotificationsDataSourceImpl([FlutterLocalNotificationsPlugin? plugin])
    : _plugin = plugin ?? FlutterLocalNotificationsPlugin();

  // Notifications are implemented for Android and iOS only.
  bool get _isSupported =>
      !kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS);

  Future<void> init() async {
    if (!_isSupported) return;

    await _plugin.initialize(settings: _initializationSettings);
  }

  @override
  Future<bool> requestPermission() async {
    if (!_isSupported) return false;

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        final android = _plugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >();
        final canScheduleExact =
            await android?.canScheduleExactNotifications() ?? false;
        _androidScheduleMode = canScheduleExact
            ? AndroidScheduleMode.exactAllowWhileIdle
            : AndroidScheduleMode.inexactAllowWhileIdle;
        return await android?.requestNotificationsPermission() ?? false;
      case TargetPlatform.iOS:
        final iOS = _plugin
            .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin
            >();
        return await iOS?.requestPermissions(alert: true, sound: true) ?? false;
      default:
        return false;
    }
  }

  @override
  Future<void> scheduleRoundFinished({
    required PomodoroState finishedRound,
    required DateTime at,
  }) async {
    if (!_isSupported) return;

    await _plugin.zonedSchedule(
      id: _roundFinishedId,
      title: _title(finishedRound),
      body: _body(finishedRound),
      // An absolute moment in time, so the device time zone does not matter.
      scheduledDate: tz.TZDateTime.from(at, tz.UTC),
      notificationDetails: _notificationDetails,
      androidScheduleMode: _androidScheduleMode,
    );
  }

  @override
  Future<void> cancelRoundFinished() async {
    if (!_isSupported) return;

    await _plugin.cancel(id: _roundFinishedId);
  }

  String _title(PomodoroState finishedRound) => switch (finishedRound) {
    PomodoroState.pomodoro => 'Pomodoro finished',
    PomodoroState.shortBreak || PomodoroState.longBreak => 'Break is over',
  };

  String _body(PomodoroState finishedRound) => switch (finishedRound) {
    PomodoroState.pomodoro => 'Time to take a break.',
    PomodoroState.shortBreak ||
    PomodoroState.longBreak => 'Time to get back to focus.',
  };
}

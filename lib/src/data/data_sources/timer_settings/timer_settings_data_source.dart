import 'package:pomodorro/src/data/models/timer_settings.dart';

abstract class TimerSettingsDataSource {
  TimerSettings getTimerSettings();

  Future<void> setTimerSettings(TimerSettings timerSettings);
}

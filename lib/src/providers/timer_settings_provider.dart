import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodorro/src/data/data_sources/timer_settings/timer_settings_data_source_provider.dart';
import 'package:pomodorro/src/data/models/timer_settings.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'timer_settings_provider.g.dart';

/*final timerSettingsProvider =
    NotifierProvider<TimerSettingsNotifier, TimerSettings>(
  () => TimerSettingsNotifier(),
);

class TimerSettingsNotifier extends Notifier<TimerSettings> {
  late final timerDataSource = ref.read(timerSettingsDataSourceProvider);

  @override
  TimerSettings build() {
    return timerDataSource.getTimerSettings();
  }

  void setTimerSettings(TimerSettings timerSettings) {
    if (timerSettings == state) return;
    timerDataSource.setTimerSettings(timerSettings);
    state = timerSettings;
  }
}*/

@riverpod
class TimerSettingsNotifier extends _$TimerSettingsNotifier {
  late final timerDataSource = ref.read(timerSettingsDataSourceProvider);

  @override
  TimerSettings build() => timerDataSource.getTimerSettings();

  void setTimerSettings(TimerSettings timerSettings) {
    if (timerSettings == state) return;
    timerDataSource.setTimerSettings(timerSettings);
    state = timerSettings;
  }
}

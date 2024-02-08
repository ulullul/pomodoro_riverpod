import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pomodorro/shared/const/timer_state.dart';
import 'package:pomodorro/src/providers/shared_preferences_provider.dart';
import 'package:pomodorro/src/providers/timer/timer_notifier.dart';
import 'package:shared_preferences/shared_preferences.dart';

ProviderContainer createContainer({
  ProviderContainer? parent,
  List<Override> overrides = const [],
  List<ProviderObserver>? observers,
}) {
  final container = ProviderContainer(
    parent: parent,
    overrides: overrides,
    observers: observers,
  );

  addTearDown(container.dispose);

  return container;
}

void main() {
  group('Timer logic tests', () {
    test('Timer should be at initial state at the start', () async {
      SharedPreferences.setMockInitialValues({});
      final prefsInstance = await SharedPreferences.getInstance();

      final container = createContainer(overrides: [
        sharedPreferencesProvider.overrideWithValue(prefsInstance),
      ]);
      final timer = container.read(timerProvider);
      expect(timer.timerState, TimerStateEnum.initial);
    });

    test('Start timer should set the state to running', () async {
      SharedPreferences.setMockInitialValues({});
      final prefsInstance = await SharedPreferences.getInstance();

      final container = createContainer(overrides: [
        sharedPreferencesProvider.overrideWithValue(prefsInstance),
      ]);

      final timerState = container.listen(timerProvider, (_, __) {});
      final timer = container.read(timerProvider.notifier);
      timer.toggleTimer();
      expect(timerState.read().timerState, TimerStateEnum.running);
    });
  });

  test('Pause timer should set the state to paused', () async {
    SharedPreferences.setMockInitialValues({});
    final prefsInstance = await SharedPreferences.getInstance();

    final container = createContainer(overrides: [
      sharedPreferencesProvider.overrideWithValue(prefsInstance),
    ]);

    final timerState = container.listen(timerProvider, (_, __) {});
    final timer = container.read(timerProvider.notifier);
    timer.toggleTimer();
    timer.toggleTimer();
    expect(timerState.read().timerState, TimerStateEnum.paused);
  });

  test('Resuming the time should set the state to running', () async {
    SharedPreferences.setMockInitialValues({});
    final prefsInstance = await SharedPreferences.getInstance();

    final container = createContainer(overrides: [
      sharedPreferencesProvider.overrideWithValue(prefsInstance),
    ]);

    final timerState = container.listen(timerProvider, (_, __) {});
    final timer = container.read(timerProvider.notifier);

    timer.toggleTimer();
    timer.toggleTimer();
    timer.toggleTimer();

    expect(timerState.read().timerState, TimerStateEnum.running);
  });
}

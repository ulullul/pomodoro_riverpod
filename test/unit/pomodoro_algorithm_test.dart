import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pomodorro/shared/const/pomodoro_state.dart';
import 'package:pomodorro/src/providers/pomodoro_state_provider.dart';
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

const defaultDelay = Duration(seconds: 3);

Future<void> wait() {
  return Future.delayed(defaultDelay);
}

void main() {
  test('Pomodoro states switching works correctly', () async {
    SharedPreferences.setMockInitialValues({
      'timer_settings': '{"pomodoro":1,"shortBreak":1,"longBreak":1}',
    });
    final prefsInstance = await SharedPreferences.getInstance();

    final container = createContainer(overrides: [
      sharedPreferencesProvider.overrideWithValue(prefsInstance),
    ]);

    final pomodoroNotifier = container.read(timerNotifierProvider.notifier);
    final appState =
        container.listen(pomodoroStateNotifierProvider, (_, __) {});

    // Initial state
    expect(appState.read(), PomodoroState.pomodoro);

    // 1st pomodoro
    pomodoroNotifier.toggleTimer();
    await wait();
    expect(appState.read(), PomodoroState.shortBreak);

    // 1st short break
    pomodoroNotifier.toggleTimer();
    await wait();
    expect(appState.read(), PomodoroState.pomodoro);

    // 2nd pomodoro
    pomodoroNotifier.toggleTimer();
    await wait();
    expect(appState.read(), PomodoroState.shortBreak);

    // 2nd short break
    pomodoroNotifier.toggleTimer();
    await wait();
    expect(appState.read(), PomodoroState.pomodoro);

    // 3rd pomodoro
    pomodoroNotifier.toggleTimer();
    await wait();
    expect(appState.read(), PomodoroState.shortBreak);

    // 3rd short break
    pomodoroNotifier.toggleTimer();
    await wait();
    expect(appState.read(), PomodoroState.pomodoro);

    // 4th pomodoro
    pomodoroNotifier.toggleTimer();
    await wait();
    expect(appState.read(), PomodoroState.longBreak);

    // Long break
    pomodoroNotifier.toggleTimer();
    await wait();
    expect(appState.read(), PomodoroState.pomodoro);
  });
}

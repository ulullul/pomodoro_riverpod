import 'package:clock/clock.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pomodorro/shared/const/pomodoro_state.dart';
import 'package:pomodorro/shared/const/timer_state.dart';
import 'package:pomodorro/src/data/data_sources/notifications/notifications_data_source_provider.dart';
import 'package:pomodorro/src/providers/pomodoro_state_provider.dart';
import 'package:pomodorro/src/providers/shared_preferences_provider.dart';
import 'package:pomodorro/src/providers/timer/timer_notifier.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/fake_notifications_data_source.dart';

void main() {
  late SharedPreferences prefsInstance;
  late FakeNotificationsDataSource notifications;

  ProviderContainer createContainer() {
    final container = ProviderContainer(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefsInstance),
        notificationsDataSourceProvider.overrideWithValue(notifications),
      ],
    );
    addTearDown(container.dispose);
    container.listen(timerNotifierProvider, (_, _) {});
    container.listen(pomodoroStateNotifierProvider, (_, _) {});

    return container;
  }

  setUp(() async {
    SharedPreferences.setMockInitialValues({
      'timer_settings': '{"pomodoro":60,"shortBreak":30,"longBreak":30}',
    });
    prefsInstance = await SharedPreferences.getInstance();
    notifications = FakeNotificationsDataSource();
  });

  group('Timer notifications tests', () {
    test('Starting the timer schedules a notification for the round end', () {
      fakeAsync((async) {
        final container = createContainer();
        final startedAt = clock.now();

        container.read(timerNotifierProvider.notifier).toggleTimer();
        async.flushMicrotasks();

        expect(notifications.scheduled, (
          finishedRound: PomodoroState.pomodoro,
          at: startedAt.add(const Duration(seconds: 60)),
        ));
      });
    });

    test('Notification is not scheduled without the permission', () {
      fakeAsync((async) {
        notifications.isPermissionGranted = false;
        final container = createContainer();

        container.read(timerNotifierProvider.notifier).toggleTimer();
        async.flushMicrotasks();

        expect(notifications.scheduleCalls, 0);
      });
    });

    test('Pausing the timer cancels the scheduled notification', () {
      fakeAsync((async) {
        final container = createContainer();
        final timer = container.read(timerNotifierProvider.notifier);

        timer.toggleTimer();
        async.elapse(const Duration(seconds: 10));
        timer.toggleTimer();
        async.flushMicrotasks();

        expect(notifications.cancelCalls, 1);
        expect(notifications.scheduled, isNull);
      });
    });

    test('Resuming the timer schedules a notification for the time left', () {
      fakeAsync((async) {
        final container = createContainer();
        final timer = container.read(timerNotifierProvider.notifier);

        timer.toggleTimer();
        async.elapse(const Duration(seconds: 10));
        timer.toggleTimer();
        async.elapse(const Duration(minutes: 5));
        final resumedAt = clock.now();
        timer.toggleTimer();
        async.flushMicrotasks();

        expect(notifications.scheduled, (
          finishedRound: PomodoroState.pomodoro,
          at: resumedAt.add(const Duration(seconds: 50)),
        ));
      });
    });

    test('Restarting the timer cancels the scheduled notification', () {
      fakeAsync((async) {
        final container = createContainer();

        container.read(timerNotifierProvider.notifier).toggleTimer();
        async.elapse(const Duration(seconds: 10));
        container.invalidate(timerNotifierProvider);
        container.read(timerNotifierProvider);
        async.flushMicrotasks();

        expect(notifications.cancelCalls, 1);
        expect(notifications.scheduled, isNull);
      });
    });

    test('Notification is not scheduled if the timer is paused while the '
        'permission is requested', () {
      fakeAsync((async) {
        final container = createContainer();
        final timer = container.read(timerNotifierProvider.notifier);

        timer.toggleTimer();
        timer.toggleTimer();
        async.flushMicrotasks();

        expect(notifications.scheduleCalls, 0);
      });
    });

    test('Finished round keeps its notification and switches the state', () {
      fakeAsync((async) {
        final container = createContainer();

        container.read(timerNotifierProvider.notifier).toggleTimer();
        async.elapse(const Duration(seconds: 62));

        expect(notifications.cancelCalls, 0);
        expect(
          container.read(pomodoroStateNotifierProvider),
          PomodoroState.shortBreak,
        );
        expect(
          container.read(timerNotifierProvider).timerState,
          TimerStateEnum.initial,
        );
      });
    });

    test('Break notification is scheduled for the break round', () {
      fakeAsync((async) {
        final container = createContainer();
        final timer = container.read(timerNotifierProvider.notifier);

        timer.toggleTimer();
        async.elapse(const Duration(seconds: 62));
        final startedAt = clock.now();
        timer.toggleTimer();
        async.flushMicrotasks();

        expect(notifications.scheduled, (
          finishedRound: PomodoroState.shortBreak,
          at: startedAt.add(const Duration(seconds: 30)),
        ));
      });
    });

    test('Timer catches up after the app was suspended', () {
      fakeAsync((async) {
        final container = createContainer();

        container.read(timerNotifierProvider.notifier).toggleTimer();
        async.elapse(const Duration(seconds: 10));
        expect(container.read(timerNotifierProvider).secondsLeft, 50);

        // Time passes, but the timers do not fire.
        async.elapseBlocking(const Duration(seconds: 20));
        async.elapse(const Duration(seconds: 1));
        expect(container.read(timerNotifierProvider).secondsLeft, 29);

        async.elapseBlocking(const Duration(minutes: 10));
        async.elapse(const Duration(seconds: 2));
        expect(
          container.read(pomodoroStateNotifierProvider),
          PomodoroState.shortBreak,
        );
      });
    });
  });
}

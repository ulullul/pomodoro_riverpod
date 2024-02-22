import 'package:pomodorro/shared/const/pomodoro_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pomodoro_state_provider.g.dart';

@riverpod
class PomodoroStateNotifier extends _$PomodoroStateNotifier {
  @override
  PomodoroState build() => PomodoroState.pomodoro;
}

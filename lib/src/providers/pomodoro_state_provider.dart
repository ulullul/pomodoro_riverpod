// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodorro/shared/const/pomodoro_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pomodoro_state_provider.g.dart';
/*
final pomodoroStateProvider = StateProvider<PomodoroState>((ref) {
  return PomodoroState.pomodoro;
});
*/
@riverpod
class PomodoroStateNotifier extends _$PomodoroStateNotifier {
  @override
  PomodoroState build() => PomodoroState.pomodoro;
}

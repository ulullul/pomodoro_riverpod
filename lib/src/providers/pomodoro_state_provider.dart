import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodorro/shared/const/pomodoro_state.dart';

final pomodoroStateProvider = StateProvider<PomodoroState>((ref) {
  return PomodoroState.pomodoro;
});

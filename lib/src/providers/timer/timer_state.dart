import 'package:pomodorro/shared/const/timer_state.dart';

class TimerState {
  final int secondsLeft;
  final TimerStateEnum timerState;

  TimerState({
    required this.secondsLeft,
    required this.timerState,
  });

  TimerState copyWith({
    int? secondsLeft,
    TimerStateEnum? timerState,
  }) {
    return TimerState(
      secondsLeft: secondsLeft ?? this.secondsLeft,
      timerState: timerState ?? this.timerState,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TimerState &&
        other.secondsLeft == secondsLeft &&
        other.timerState == timerState;
  }

  @override
  int get hashCode => secondsLeft.hashCode ^ timerState.hashCode;
}

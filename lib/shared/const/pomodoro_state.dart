enum PomodoroState {
  pomodoro('pomodoro'),
  shortBreak('short break'),
  longBreak('long break');

  final String name;

  const PomodoroState(this.name);
}
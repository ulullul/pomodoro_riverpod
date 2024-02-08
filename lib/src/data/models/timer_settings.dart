class TimerSettings {
  final int pomodoro;
  final int shortBreak;
  final int longBreak;

  TimerSettings({
    this.pomodoro = 1500,
    this.shortBreak = 300,
    this.longBreak = 900,
  });

  Map<String, dynamic> toJson() {
    return {
      'pomodoro': pomodoro,
      'shortBreak': shortBreak,
      'longBreak': longBreak,
    };
  }

  factory TimerSettings.fromJson(Map<String, dynamic> json) {
    return TimerSettings(
      pomodoro: json['pomodoro'] as int,
      shortBreak: json['shortBreak'] as int,
      longBreak: json['longBreak'] as int,
    );
  }

  TimerSettings copyWith({
    int? pomodoro,
    int? shortBreak,
    int? longBreak,
  }) {
    return TimerSettings(
      pomodoro: pomodoro ?? this.pomodoro,
      shortBreak: shortBreak ?? this.shortBreak,
      longBreak: longBreak ?? this.longBreak,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TimerSettings &&
        other.pomodoro == pomodoro &&
        other.shortBreak == shortBreak &&
        other.longBreak == longBreak;
  }

  @override
  int get hashCode =>
      pomodoro.hashCode ^ shortBreak.hashCode ^ longBreak.hashCode;
}

import 'package:flutter/material.dart';
import 'package:pomodorro/shared/extensions/context_extension.dart';
import 'package:pomodorro/shared/extensions/int_extension.dart';
import 'package:pomodorro/src/data/models/timer_settings.dart';
import 'package:pomodorro/src/pages/settings/widgets/section_headline.dart';
import 'package:pomodorro/src/pages/settings/widgets/time_section/time_section_item.dart';

class TimeSectionContainer extends StatelessWidget {
  final TimerSettings timerSettings;
  final ValueChanged<int> onPomodoroSelected;
  final ValueChanged<int> onShortBreakSelected;
  final ValueChanged<int> onLongBreakSelected;

  const TimeSectionContainer({
    super.key,
    required this.timerSettings,
    required this.onPomodoroSelected,
    required this.onShortBreakSelected,
    required this.onLongBreakSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: context.isMobile
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        const SectionHeadline(text: 'time (minutes)'),
        const SizedBox(height: 15),
        context.isMobile
            ? _FieldsMobileLayout(
                timerSettings: timerSettings,
                onPomodoroSelected: onPomodoroSelected,
                onShortBreakSelected: onShortBreakSelected,
                onLongBreakSelected: onLongBreakSelected,
              )
            : _FieldsTabletLayout(
                timerSettings: timerSettings,
                onPomodoroSelected: onPomodoroSelected,
                onShortBreakSelected: onShortBreakSelected,
                onLongBreakSelected: onLongBreakSelected,
              ),
      ],
    );
  }
}

class _FieldsMobileLayout extends StatelessWidget {
  final TimerSettings timerSettings;
  final ValueChanged<int> onPomodoroSelected;
  final ValueChanged<int> onShortBreakSelected;
  final ValueChanged<int> onLongBreakSelected;

  const _FieldsMobileLayout({
    required this.timerSettings,
    required this.onPomodoroSelected,
    required this.onShortBreakSelected,
    required this.onLongBreakSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TimeSectionItem(
          title: 'pomodoro',
          initialValue: timerSettings.pomodoro,
          onTimeChanged: (value) => onPomodoroSelected(value.toSeconds),
        ),
        const SizedBox(height: 8),
        TimeSectionItem(
          title: 'short break',
          initialValue: timerSettings.shortBreak,
          onTimeChanged: (value) => onShortBreakSelected(value.toSeconds),
        ),
        const SizedBox(height: 8),
        TimeSectionItem(
          title: 'long break',
          initialValue: timerSettings.longBreak,
          onTimeChanged: (value) => onLongBreakSelected(value.toSeconds),
        ),
      ],
    );
  }
}

class _FieldsTabletLayout extends StatelessWidget {
  final TimerSettings timerSettings;
  final ValueChanged<int> onPomodoroSelected;
  final ValueChanged<int> onShortBreakSelected;
  final ValueChanged<int> onLongBreakSelected;

  const _FieldsTabletLayout({
    required this.timerSettings,
    required this.onPomodoroSelected,
    required this.onShortBreakSelected,
    required this.onLongBreakSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TimeSectionItem(
            title: 'pomodoro',
            initialValue: timerSettings.pomodoro,
            onTimeChanged: (value) => onPomodoroSelected(value.toSeconds),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: TimeSectionItem(
            title: 'short break',
            initialValue: timerSettings.shortBreak,
            onTimeChanged: (value) => onShortBreakSelected(value.toSeconds),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: TimeSectionItem(
            title: 'long break',
            initialValue: timerSettings.longBreak,
            onTimeChanged: (value) => onLongBreakSelected(value.toSeconds),
          ),
        ),
      ],
    );
  }
}

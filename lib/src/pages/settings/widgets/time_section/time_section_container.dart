import 'package:flutter/material.dart';
import 'package:pomodorro/shared/extensions/context_extension.dart';
import 'package:pomodorro/shared/extensions/int_extension.dart';
import 'package:pomodorro/src/data/models/timer_settings.dart';
import 'package:pomodorro/src/pages/settings/widgets/section_headline.dart';
import 'package:pomodorro/src/pages/settings/widgets/time_section/time_section_item.dart';

class TimeSection extends StatelessWidget {
  final TimerSettings timerSettings;
  final ValueChanged<TimerSettings> onTimeSelected;

  const TimeSection({
    super.key,
    required this.timerSettings,
    required this.onTimeSelected,
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
                onTimeSelected: onTimeSelected,
              )
            : _FieldsTabletLayout(
                timerSettings: timerSettings,
                onTimeSelected: onTimeSelected,
              ),
      ],
    );
  }
}

class _FieldsMobileLayout extends StatelessWidget {
  final TimerSettings timerSettings;
  final ValueChanged<TimerSettings> onTimeSelected;

  const _FieldsMobileLayout({
    required this.timerSettings,
    required this.onTimeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TimeSectionItem(
          title: 'pomodoro',
          initialValue: timerSettings.pomodoro,
          onTimeChanged: (value) => onTimeSelected(
            timerSettings.copyWith(pomodoro: value.toSeconds),
          ),
        ),
        const SizedBox(height: 8),
        TimeSectionItem(
          title: 'short break',
          initialValue: timerSettings.shortBreak,
          onTimeChanged: (value) => onTimeSelected(
            timerSettings.copyWith(shortBreak: value.toSeconds),
          ),
        ),
        const SizedBox(height: 8),
        TimeSectionItem(
          title: 'long break',
          initialValue: timerSettings.longBreak,
          onTimeChanged: (value) => onTimeSelected(
            timerSettings.copyWith(longBreak: value.toSeconds),
          ),
        ),
      ],
    );
  }
}

class _FieldsTabletLayout extends StatelessWidget {
  final TimerSettings timerSettings;
  final ValueChanged<TimerSettings> onTimeSelected;

  const _FieldsTabletLayout({
    required this.timerSettings,
    required this.onTimeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TimeSectionItem(
            title: 'pomodoro',
            initialValue: timerSettings.pomodoro,
            onTimeChanged: (value) => onTimeSelected(
              timerSettings.copyWith(pomodoro: value.toSeconds),
            ),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: TimeSectionItem(
            title: 'short break',
            initialValue: timerSettings.shortBreak,
            onTimeChanged: (value) => onTimeSelected(
              timerSettings.copyWith(shortBreak: value.toSeconds),
            ),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: TimeSectionItem(
            title: 'long break',
            initialValue: timerSettings.longBreak,
            onTimeChanged: (value) => onTimeSelected(
              timerSettings.copyWith(longBreak: value.toSeconds),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodorro/shared/const/pomodoro_state.dart';
import 'package:pomodorro/shared/theme/theme.dart';
import 'package:pomodorro/src/providers/pomodoro_state_provider.dart';
import 'package:pomodorro/src/providers/theme_settings_provider.dart';

class HomeSegmentedButton extends ConsumerWidget {
  const HomeSegmentedButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeSettingsNotifierProvider);
    final currentAppAction = ref.watch(pomodoroStateNotifierProvider);
    return Material(
      type: MaterialType.transparency,
      child: CustomSlidingSegmentedControl<PomodoroState>(
        initialValue: currentAppAction,
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: AppColors.black,
          borderRadius: BorderRadius.circular(30),
        ),
        innerPadding: const EdgeInsets.all(8),
        isShowDivider: false,
        thumbDecoration: BoxDecoration(
          color: theme.accentColor,
          borderRadius: BorderRadius.circular(25),
        ),
        isDisabled: true,
        onValueChanged: (value) {},
        children: {
          PomodoroState.pomodoro: _HomeSegmentedButtonItem(
            value: PomodoroState.pomodoro,
            slidingButtonSelection: currentAppAction,
          ),
          PomodoroState.shortBreak: _HomeSegmentedButtonItem(
            value: PomodoroState.shortBreak,
            slidingButtonSelection: currentAppAction,
          ),
          PomodoroState.longBreak: _HomeSegmentedButtonItem(
            value: PomodoroState.longBreak,
            slidingButtonSelection: currentAppAction,
          ),
        },
      ),
    );
  }
}

class _HomeSegmentedButtonItem extends ConsumerWidget {
  final PomodoroState slidingButtonSelection;
  final PomodoroState value;

  const _HomeSegmentedButtonItem({
    required this.value,
    required this.slidingButtonSelection,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeSettingsNotifierProvider);
    return Padding(
      padding: const EdgeInsets.all(8),
      child: AnimatedDefaultTextStyle(
        duration: const Duration(milliseconds: 300),
        style: TextStyle(
          fontFamily: theme.appFontFamily.name,
          color: value == slidingButtonSelection
              ? AppColors.darkBlue
              : AppColors.lightBlue,
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
        child: Text(value.name),
      ),
    );
  }
}

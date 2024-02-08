import 'package:defer_pointer/defer_pointer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodorro/shared/extensions/context_extension.dart';
import 'package:pomodorro/shared/theme/theme.dart';
import 'package:pomodorro/shared/widgets/app_button.dart';
import 'package:pomodorro/src/data/models/theme_settings.dart';
import 'package:pomodorro/src/data/models/timer_settings.dart';
import 'package:pomodorro/src/pages/settings/widgets/color_section/color_section.dart';
import 'package:pomodorro/src/pages/settings/widgets/settings_app_bar.dart';
import 'package:pomodorro/src/pages/settings/widgets/time_section/time_section_container.dart';
import 'package:pomodorro/src/providers/theme_settings_provider.dart';
import 'package:pomodorro/src/providers/timer/timer_notifier.dart';
import 'package:pomodorro/src/providers/timer_settings_provider.dart';

import 'widgets/font_section/font_section.dart';
import 'widgets/settings_separator.dart';

class SettingsDialog extends ConsumerStatefulWidget {
  const SettingsDialog({super.key});

  @override
  ConsumerState<SettingsDialog> createState() => _SettingsDialogState();
}

class _SettingsDialogState extends ConsumerState<SettingsDialog> {
  late ThemeSettings _themeSettings;
  late TimerSettings _timerSettings;

  @override
  void initState() {
    _themeSettings = ref.read(themeSettingsProvider);
    _timerSettings = ref.read(timerSettingsProvider);
    super.initState();
  }

  void _onFontSelected(AppFontFamily font) {
    setState(() {
      _themeSettings = _themeSettings.copyWith(
        appFontFamily: font,
      );
    });
  }

  void _onColorSelected(Color color) {
    setState(() {
      _themeSettings = _themeSettings.copyWith(
        accentColor: color,
      );
    });
  }

  void onTimerSettingsChanged(
      {int? pomodoro, int? shortBreak, int? longBreak}) {
    setState(() {
      _timerSettings = _timerSettings.copyWith(
        pomodoro: pomodoro,
        shortBreak: shortBreak,
        longBreak: longBreak,
      );
    });
  }

  void onApply() {
    ref.read(themeSettingsProvider.notifier).setTheme(_themeSettings);
    ref.read(timerSettingsProvider.notifier).setTimerSettings(_timerSettings);
    ref.invalidate(timerProvider);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return DeferredPointerHandler(
      child: Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 540,
            maxHeight: context.isMobile ? double.infinity : 490,
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              DecoratedBox(
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: CustomScrollView(
                  shrinkWrap: true,
                  slivers: [
                    const SettingsAppBar(),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 24,
                          right: 24,
                          top: 24,
                          bottom: 48,
                        ),
                        child: Column(
                          children: [
                            TimeSectionContainer(
                              timerSettings: _timerSettings.toMinutes,
                              onPomodoroSelected: (val) =>
                                  onTimerSettingsChanged(pomodoro: val),
                              onShortBreakSelected: (val) =>
                                  onTimerSettingsChanged(shortBreak: val),
                              onLongBreakSelected: (val) =>
                                  onTimerSettingsChanged(longBreak: val),
                            ),
                            const SettingsSeparator(),
                            FontSection(
                              selected: _themeSettings.appFontFamily,
                              onSelected: _onFontSelected,
                            ),
                            const SettingsSeparator(),
                            ColorSection(
                              selected: _themeSettings.accentColor,
                              onSelected: _onColorSelected,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: -20,
                left: 0,
                right: 0,
                child: Center(
                  child: DeferPointer(
                    child: AppButton(
                      onPressed: onApply,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

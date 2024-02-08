import 'package:flutter/material.dart';
import 'package:pomodorro/shared/theme/theme.dart';
import 'package:pomodorro/src/pages/settings/settings_dialog.dart';

class SettingsButton extends StatelessWidget {
  const SettingsButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => const SettingsDialog(),
        );
      },
      tooltip: 'Settings',
      backgroundColor: Colors.transparent,
      elevation: 0,
      shape: const CircleBorder(),
      child: const Icon(
        Icons.settings,
        color: AppColors.lightBlue,
        size: 28,
      ),
    );
  }
}

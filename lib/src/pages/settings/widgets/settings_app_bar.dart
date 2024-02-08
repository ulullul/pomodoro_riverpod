import 'package:flutter/material.dart';
import 'package:pomodorro/shared/extensions/context_extension.dart';
import 'package:pomodorro/shared/theme/theme.dart';

class SettingsAppBar extends StatelessWidget {
  const SettingsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      toolbarHeight: context.isMobile ? 72 : 93,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        side: BorderSide(color: AppColors.pileBeige, width: 1),
      ),
      titleTextStyle: TextStyle(
        fontFamily: AppFontFamily.kumbhSans.name,
        fontWeight: FontWeight.bold,
        fontSize: context.isMobile ? 20 : 28,
        color: AppColors.black,
      ),
      title: const Text('Settings'),
      backgroundColor: AppColors.white,
      automaticallyImplyLeading: false,
      actions: const [CloseButton()],
    );
  }
}

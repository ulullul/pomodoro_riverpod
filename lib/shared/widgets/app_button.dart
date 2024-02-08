import 'package:flutter/material.dart';
import 'package:pomodorro/shared/theme/theme.dart';

class AppButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const AppButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(140, 53),
        backgroundColor: AppColors.red,
        foregroundColor: AppColors.white,
        padding: const EdgeInsets.symmetric(horizontal: 40),
        textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontFamily: AppFontFamily.kumbhSans.name,
        ),
      ),
      child: const Text('Apply'),
    );
  }
}

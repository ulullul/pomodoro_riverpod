import 'package:flutter/material.dart';
import 'package:pomodorro/shared/extensions/context_extension.dart';
import 'package:pomodorro/shared/theme/theme.dart';

class SectionHeadline extends StatelessWidget {
  final String text;

  const SectionHeadline({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      textAlign: TextAlign.start,
      style: TextStyle(
        fontFamily: AppFontFamily.kumbhSans.name,
        fontSize: context.isMobile ? 11 : 13,
        fontWeight: FontWeight.bold,
        letterSpacing: 4,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pomodorro/shared/extensions/context_extension.dart';
import 'package:pomodorro/shared/theme/theme.dart';
import 'package:pomodorro/src/pages/home/widgets/timer/home_timer.dart';

class TimerContainer extends StatelessWidget {
  const TimerContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: context.isMobile ? 300 : 410,
      height: context.isMobile ? 300 : 410,
      decoration: const ShapeDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff161932), Color(0xff272a4e)],
          stops: [0.4, 0.6],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        shape: CircleBorder(),
        shadows: [
          BoxShadow(
            color: Color(0xFF12152F),
            blurRadius: 100,
            offset: Offset(50, 50),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Color(0xFF272C5A),
            blurRadius: 100,
            offset: Offset(-50, -50),
            spreadRadius: 0,
          )
        ],
      ),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
          color: AppColors.black,
          shape: BoxShape.circle,
        ),
        child: const HomeTimer(),
      ),
    );
  }
}

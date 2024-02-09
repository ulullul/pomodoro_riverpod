import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodorro/shared/extensions/context_extension.dart';
import 'package:pomodorro/shared/theme/theme.dart';
import 'package:pomodorro/src/pages/home/widgets/home_segmented_button.dart';
import 'package:pomodorro/src/pages/home/widgets/timer/timer_container.dart';
import 'package:pomodorro/src/providers/timer/timer_notifier.dart';

import 'widgets/settings_button.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        titleTextStyle: TextStyle(
          fontFamily: AppFontFamily.kumbhSans.name,
          fontWeight: FontWeight.bold,
          fontSize: context.isMobile ? 24 : 32,
          color: AppColors.lightGrey,
        ),
        title: const Text('pomodoro'),
        actions: [
          IconButton(
            onPressed: () => ref.invalidate(timerNotifierProvider),
            tooltip: 'Restart timer',
            icon: const Icon(Icons.refresh, color: AppColors.lightGrey),
          ),
        ],
      ),
      body: const Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(height: 40),
          Align(
            alignment: Alignment.topCenter,
            child: HomeSegmentedButton(),
          ),
          Expanded(
            child: Center(
              child: TimerContainer(),
            ),
          ),
        ],
      ),
      floatingActionButton: const SettingsButton(),
    );
  }
}

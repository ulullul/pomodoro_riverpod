import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodorro/shared/extensions/int_extension.dart';
import 'package:pomodorro/src/providers/timer/timer_notifier.dart';

final formattedTimerProvider = Provider.autoDispose<String>((ref) {
  final seconds = ref.watch(timerProvider).secondsLeft;
  return seconds.formattedDurationString;
});

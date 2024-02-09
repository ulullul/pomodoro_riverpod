import 'package:pomodorro/shared/extensions/int_extension.dart';
import 'package:pomodorro/src/providers/timer/timer_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'formatted_timer_provider.g.dart';

/*final formattedTimerNotifierProvider = Provider.autoDispose<String>((ref) {
  return ref.watch(timerNotifierProvider).secondsLeft.formattedDurationString;
});*/

@riverpod
class FormattedTimer extends _$FormattedTimer {
  @override
  String build() =>
      ref.watch(timerNotifierProvider).secondsLeft.formattedDurationString;
}

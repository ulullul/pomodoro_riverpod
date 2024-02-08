import 'package:flutter/material.dart';
import 'package:pomodorro/shared/extensions/context_extension.dart';
import 'package:pomodorro/shared/widgets/widgets.dart';

class TimeSectionItem extends StatelessWidget {
  final String title;
  final int initialValue;
  final ValueChanged<int> onTimeChanged;

  const TimeSectionItem({
    super.key,
    required this.title,
    required this.initialValue,
    required this.onTimeChanged,
  });

  @override
  Widget build(BuildContext context) {

    return context.isMobile
        ? Row(
            children: [
              Expanded(child: Text(title)),
              Flexible(
                child: AppNumberInput(
                  initialValue: initialValue,
                  onTimeChanged: onTimeChanged,
                ),
              ),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title),
              const SizedBox(height: 10),
              AppNumberInput(
                initialValue: initialValue,
                onTimeChanged: onTimeChanged,
              ),
            ],
          );
  }
}

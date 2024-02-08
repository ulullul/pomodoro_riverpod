import 'package:flutter/material.dart';
import 'package:pomodorro/shared/extensions/list_extension.dart';

class PickerWidget<T> extends StatelessWidget {
  final List<T> items;
  final T selected;
  final Widget Function(BuildContext, T, bool isSelected) builder;
  final ValueChanged<T> onSelected;

  const PickerWidget({
    super.key,
    required this.items,
    required this.selected,
    required this.builder,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 5,
      spacing: 5,
      children: items
          .mapIndexed((index, value) => GestureDetector(
                onTap: () => onSelected(value),
                child: builder(context, value, value == selected),
              ))
          .toList(),
    );
  }
}

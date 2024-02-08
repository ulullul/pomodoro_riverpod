import 'package:flutter/material.dart';
import 'package:pomodorro/shared/theme/colors.dart';
import 'package:pomodorro/shared/widgets/picker_widget.dart';

class ColorPicker extends StatelessWidget {
  final ValueChanged<Color> onSelected;
  final Color? selected;

  const ColorPicker({
    super.key,
    required this.onSelected,
    this.selected,
  });

  static const items = [AppColors.red, AppColors.aqua, AppColors.purple];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: PickerWidget<Color>(
        items: items,
        selected: selected ?? AppColors.red,
        onSelected: onSelected,
        builder: (_, color, isSelected) => Container(
          margin: const EdgeInsets.all(8),
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: isSelected
              ? const Icon(Icons.check, color: AppColors.black, size: 24)
              : null,
        ),
      ),
    );
  }
}

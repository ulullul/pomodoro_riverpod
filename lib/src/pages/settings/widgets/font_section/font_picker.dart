import 'package:flutter/material.dart';
import 'package:pomodorro/shared/theme/colors.dart';
import 'package:pomodorro/shared/theme/font_family.dart';
import 'package:pomodorro/shared/widgets/picker_widget.dart';

class FontPicker extends StatelessWidget {
  final AppFontFamily? selected;
  final ValueChanged<AppFontFamily> onSelected;

  const FontPicker({
    super.key,
    required this.onSelected,
    this.selected,
  });

  static const items = AppFontFamily.values;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: PickerWidget<AppFontFamily>(
        items: items,
        selected: selected ?? AppFontFamily.kumbhSans,
        onSelected: onSelected,
        builder: (_, color, isSelected) => Container(
          margin: const EdgeInsets.all(8),
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.black : AppColors.lightGrey,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              'Aa',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: color.name,
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: isSelected ? AppColors.lightGrey : AppColors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

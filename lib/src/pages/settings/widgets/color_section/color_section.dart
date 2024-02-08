import 'package:flutter/material.dart';
import 'package:pomodorro/shared/extensions/context_extension.dart';
import 'package:pomodorro/src/pages/settings/widgets/section_headline.dart';

import 'color_picker.dart';

class ColorSection extends StatelessWidget {
  final Color? selected;
  final ValueChanged<Color> onSelected;

  const ColorSection({super.key, required this.onSelected, this.selected});

  @override
  Widget build(BuildContext context) {
    return context.isMobile
        ? Column(
            children: [
              const SectionHeadline(text: 'color'),
              const SizedBox(height: 15),
              ColorPicker(
                onSelected: onSelected,
                selected: selected,
              ),
            ],
          )
        : Row(
            children: [
              const Expanded(child: SectionHeadline(text: 'color')),
              const SizedBox(width: 15),
              ColorPicker(
                onSelected: onSelected,
                selected: selected,
              ),
            ],
          );
  }
}

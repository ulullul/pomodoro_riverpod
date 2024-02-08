import 'package:flutter/material.dart';
import 'package:pomodorro/shared/extensions/context_extension.dart';
import 'package:pomodorro/shared/theme/font_family.dart';
import 'package:pomodorro/src/pages/settings/widgets/section_headline.dart';

import 'font_picker.dart';

class FontSection extends StatelessWidget {
  final AppFontFamily? selected;
  final ValueChanged<AppFontFamily> onSelected;

  const FontSection({super.key, required this.onSelected, this.selected});

  @override
  Widget build(BuildContext context) {
    return context.isMobile
        ? Column(
            children: [
              const SectionHeadline(text: 'font'),
              const SizedBox(height: 15),
              FontPicker(
                onSelected: onSelected,
                selected: selected,
              ),
            ],
          )
        : Row(
            children: [
              const Expanded(child: SectionHeadline(text: 'font')),
              const SizedBox(width: 15),
              FontPicker(
                onSelected: onSelected,
                selected: selected,
              ),
            ],
          );
  }
}

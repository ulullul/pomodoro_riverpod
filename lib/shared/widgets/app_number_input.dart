import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pomodorro/shared/images/app_svg_assets.dart';
import 'package:pomodorro/shared/theme/theme.dart';
import 'package:pomodorro/shared/utils/throtler.dart';

class AppNumberInput extends StatefulWidget {
  final ValueChanged<int> onTimeChanged;
  final int initialValue;

  const AppNumberInput({
    super.key,
    required this.onTimeChanged,
    required this.initialValue,
  });

  @override
  State<AppNumberInput> createState() => _AppNumberInputState();
}

class _AppNumberInputState extends State<AppNumberInput> {
  late final TextEditingController _controller;
  final _throttler = Throttler(milliseconds: 100);

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue.toString());
  }

  void updateValue(int value) {
    _controller.text = value.toString();
    widget.onTimeChanged(value);
  }

  void onVerticalDragUpdate(DragUpdateDetails details) {
    final isScrollingUp = details.primaryDelta! < 0;
    final isScrollingDown = !isScrollingUp;
    final isReachingMinValue = (int.tryParse(_controller.text) ?? 1) <= 1;

    if (isReachingMinValue && isScrollingDown) return;

    if (isScrollingUp) {
      updateValue(int.parse(_controller.text) + 1);
    } else {
      updateValue(int.parse(_controller.text) - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 140),
      child: TextField(
        controller: _controller,
        keyboardType: TextInputType.number,
        style: TextStyle(
          fontFamily: AppFontFamily.kumbhSans.name,
          color: AppColors.black,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          filled: true,
          fillColor: AppColors.lightGrey,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelText: 'Minutes',
          labelStyle: TextStyle(
            fontFamily: AppFontFamily.kumbhSans.name,
            color: AppColors.lightBlue,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          suffix: GestureDetector(
            onVerticalDragUpdate: (details) =>
                _throttler.run(() => onVerticalDragUpdate(details)),
            child: SvgPicture.asset(AppSvgAssets.numberInputArrows),
          ),
        ),
      ),
    );
  }
}

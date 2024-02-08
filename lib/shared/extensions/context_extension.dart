import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  bool get isTablet => MediaQuery.of(this).size.width > 600;
  bool get isMobile => MediaQuery.of(this).size.width <= 600;
}

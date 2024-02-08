import 'dart:ui';

import 'package:pomodorro/shared/theme/theme.dart';

class ThemeSettings {
  final Color accentColor;
  final AppFontFamily appFontFamily;

  ThemeSettings({
    this.accentColor = AppColors.red,
    this.appFontFamily = AppFontFamily.spaceMono,
  });

  Map<String, dynamic> toJson() {
    return {
      'accentColor': accentColor.value,
      'appFontFamily': appFontFamily.name.toString(),
    };
  }

  factory ThemeSettings.fromJson(Map<String, dynamic> json) {
    return ThemeSettings(
      accentColor: Color(json['accentColor'] as int),
      appFontFamily: AppFontFamily.fromString(
        json['appFontFamily'].toString(),
      ),
    );
  }

  ThemeSettings copyWith({
    Color? accentColor,
    AppFontFamily? appFontFamily,
  }) {
    return ThemeSettings(
      accentColor: accentColor ?? this.accentColor,
      appFontFamily: appFontFamily ?? this.appFontFamily,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ThemeSettings &&
        other.accentColor == accentColor &&
        other.appFontFamily == appFontFamily;
  }

  @override
  int get hashCode => accentColor.hashCode ^ appFontFamily.hashCode;
}

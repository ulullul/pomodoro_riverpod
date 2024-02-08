enum AppFontFamily {
  kumbhSans('Kumbh Sans', letterSpacing: -4, weight: 700),
  robotoSlab('Roboto Slab', letterSpacing: 0, weight: 700),
  spaceMono('Space Mono', letterSpacing: -10, weight: 400);

  final String name;
  final double letterSpacing;
  final int weight;

  const AppFontFamily(
    this.name, {
    required this.letterSpacing,
    required this.weight,
  });

  static AppFontFamily fromString(String name) => switch (name) {
        'Kumbh Sans' => AppFontFamily.kumbhSans,
        'Roboto Slab' => AppFontFamily.robotoSlab,
        'Space Mono' => AppFontFamily.spaceMono,
        _ => AppFontFamily.kumbhSans,
      };
}

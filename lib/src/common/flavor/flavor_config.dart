enum FlavorType {
  free,
  paid,
  freedev,
  paiddev,
}

class FlavorValues {
  final String titleApp;

  const FlavorValues({
    this.titleApp = "Moments Free",
  });
}

class FlavorConfig {
  final FlavorType flavor;
  final FlavorValues values;

  static FlavorConfig? _instance;

  FlavorConfig({
    this.flavor = FlavorType.freedev,
    this.values = const FlavorValues(),
  }) {
    _instance = this;
  }

  static FlavorConfig get instance => _instance ?? FlavorConfig();
}

class Singleton {
  static final Singleton _instance = Singleton._internal();
  String x = "1";
  factory Singleton() => _instance;

  Singleton._internal();
}

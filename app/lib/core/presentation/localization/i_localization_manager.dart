abstract class ILocalizationManager {
  String get currentLocale;
  List<String> get supportedLocales;
  void changeLocale(String locale);
  String translate(String key);
  bool get isRTL;
}

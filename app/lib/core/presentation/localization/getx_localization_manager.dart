import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'i_localization_manager.dart';

class GetXLocalizationManager implements ILocalizationManager {
  final Map<String, Map<String, String>> _translations;
  final String _defaultLocale;
  final List<String> _supportedLocales;

  GetXLocalizationManager({
    required Map<String, Map<String, String>> translations,
    required String defaultLocale,
    required List<String> supportedLocales,
  })  : _translations = translations,
        _defaultLocale = defaultLocale,
        _supportedLocales = supportedLocales {
    Get.updateLocale(Locale(_defaultLocale));
  }

  @override
  String get currentLocale => Get.locale?.languageCode ?? _defaultLocale;

  @override
  List<String> get supportedLocales => _supportedLocales;

  @override
  void changeLocale(String locale) {
    if (_supportedLocales.contains(locale)) {
      Get.updateLocale(Locale(locale));
    }
  }

  @override
  String translate(String key) {
    final translation = _translations[currentLocale]?[key] ??
        _translations[_defaultLocale]?[key] ??
        key;
    return translation;
  }

  @override
  bool get isRTL => Get.locale?.languageCode == 'ar';
}

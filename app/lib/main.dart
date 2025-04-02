import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/bindings/initial_binding.dart';
import 'core/config/di.dart';
import 'core/constants/app_constants.dart';
import 'core/constants/route_names.dart';
import 'core/presentation/localization/i_localization_manager.dart';
import 'core/presentation/routes/i_router.dart';
import 'core/presentation/theme/i_theme_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeManager = getIt<IThemeManager>();
    final localizationManager = getIt<ILocalizationManager>();
    final router = getIt<IRouter>();
    final initialBinding = getIt<InitialBinding>();

    return GetMaterialApp(
      title: AppConstants.appName,
      theme: themeManager.lightTheme,
      darkTheme: themeManager.darkTheme,
      themeMode: themeManager.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      initialRoute: RouteNames.pokemonList,
      getPages: router.routes,
      locale: Locale(localizationManager.currentLocale),
      supportedLocales: localizationManager.supportedLocales
          .map((locale) => Locale(locale))
          .toList(),
      translations: GetxTranslations(localizationManager),
      initialBinding: initialBinding,
    );
  }
}

class GetxTranslations extends Translations {
  final ILocalizationManager _localizationManager;

  GetxTranslations(this._localizationManager);

  @override
  Map<String, Map<String, String>> get keys => {};

  @override
  String get(String key, {String? locale}) {
    return _localizationManager.translate(key);
  }
}

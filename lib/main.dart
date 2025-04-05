import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_router.dart';
import 'core/services/connectivity_service.dart';
import 'core/di/service_locator.dart';
import 'core/presentation/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar as dependências
  await initDependencies();

  // Registra o serviço de conectividade
  Get.put(ConnectivityService());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Pokédex',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: '/',  // Começando pela splash page
      getPages: AppRouter.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}

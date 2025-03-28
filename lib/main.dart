import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_router.dart';
import 'core/services/connectivity_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      initialRoute: '/pokemon-list',
      getPages: AppRouter.routes,
    );
  }
}

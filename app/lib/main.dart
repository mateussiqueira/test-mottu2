import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'core/config/app_routes.dart';
import 'core/config/app_theme.dart';
import 'core/domain/errors/logger.dart';
import 'core/domain/errors/performance_monitor.dart';
import 'features/pokemon/data/datasources/pokemon_remote_datasource_impl.dart';
import 'features/pokemon/data/repositories/pokemon_repository_impl.dart';
import 'features/pokemon/presentation/bloc/pokemon_bloc.dart';
import 'features/pokemon_detail/presentation/controllers/i_pokemon_detail_controller.dart';
import 'features/pokemon_detail/presentation/controllers/pokemon_detail_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final httpClient = http.Client();
    final remoteDataSource = PokemonRemoteDataSourceImpl(httpClient);
    final repository = PokemonRepositoryImpl(remoteDataSource);
    final logger = LoggingLogger();
    final performanceMonitor = PerformanceMonitor();

    return MultiProvider(
      providers: [
        Provider<PokemonBloc>(
          create: (_) => PokemonBloc(repository),
        ),
      ],
      child: GetMaterialApp(
        title: 'Pokemon App',
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.system,
        onGenerateRoute: AppRoutes.onGenerateRoute,
        initialRoute: AppRoutes.home,
        initialBinding: BindingsBuilder(() {
          Get.lazyPut<IPokemonDetailController>(
            () => PokemonDetailController(
              repository: repository,
              logger: logger,
              performanceMonitor: performanceMonitor,
            ),
          );
        }),
      ),
    );
  }
}

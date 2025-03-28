import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/domain/entities/pokemon.dart';
import 'core/presentation/pages/splash_page.dart';
import 'core/presentation/theme/app_theme.dart';
import 'features/pokemon_detail/presentation/pages/pokemon_detail_page.dart';
import 'features/pokemon_list/presentation/pages/pokemon_list_page.dart';

void main() {
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
      getPages: [
        GetPage(
          name: '/',
          page: () => const SplashPage(),
        ),
        GetPage(
          name: '/pokemon-list',
          page: () => const PokemonListPage(),
        ),
        GetPage(
          name: '/pokemon-detail',
          page: () => PokemonDetailPage(
            pokemon: Get.arguments as Pokemon,
          ),
        ),
      ],
    );
  }
}

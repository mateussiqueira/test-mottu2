import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/domain/entities/pokemon.dart';
import '../../../features/pokemon_detail/presentation/pages/pokemon_detail_page.dart';
import '../../../features/pokemon_list/presentation/pages/pokemon_list_page.dart';
import '../../presentation/pages/splash_page.dart';

class AppRouter {
  static const String splash = '/';
  static const String pokemonList = '/pokemon-list';
  static const String pokemonDetail = '/pokemon-detail';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return GetPageRoute(
          page: () => const SplashPage(),
          settings: settings,
        );
      case pokemonList:
        return GetPageRoute(
          page: () => const PokemonListPage(),
          settings: settings,
        );
      case pokemonDetail:
        final pokemon = settings.arguments as Pokemon;
        return GetPageRoute(
          page: () => const PokemonDetailPage(),
          settings: settings,
        );
      default:
        return GetPageRoute(
          page: () => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
          settings: settings,
        );
    }
  }
}

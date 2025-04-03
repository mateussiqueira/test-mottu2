import 'package:flutter/material.dart';

import '../../features/pokemon/domain/entities/pokemon_entity.dart';
import '../../features/pokemon/presentation/pages/pokemon_list_page.dart';
import '../../features/pokemon_detail/presentation/pages/pokemon_detail_page.dart';

class AppRoutes {
  static const String home = '/';
  static const String pokemonDetail = '/pokemon-detail';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => const PokemonListPage(),
        );
      case pokemonDetail:
        final pokemon = settings.arguments as PokemonEntity;
        return MaterialPageRoute(
          builder: (_) => PokemonDetailPage(pokemon: pokemon),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const PokemonListPage(),
        );
    }
  }
}

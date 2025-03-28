import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/data/adapters/poke_api_adapter.dart';
import '../../../core/data/repositories/pokemon_repository_impl.dart';
import '../../../core/domain/entities/pokemon.dart';
import '../../../core/domain/repositories/pokemon_repository.dart';
import '../../../features/pokemon_detail/presentation/pages/pokemon_detail_page.dart';
import '../../../features/pokemon_list/presentation/controllers/related_pokemons_controller.dart';
import '../../../features/pokemon_list/presentation/pages/pokemon_list_page.dart';
import '../../../features/pokemon_list/presentation/pages/related_pokemons_page.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return GetPageRoute(
          page: () => const PokemonListPage(),
          binding: BindingsBuilder(() {
            final repository = PokemonRepositoryImpl(PokeApiAdapter());
            Get.put<PokemonRepository>(repository);
          }),
        );
      case '/pokemon-detail':
        final pokemon = settings.arguments as Pokemon;
        return GetPageRoute(
          page: () => PokemonDetailPage(pokemon: pokemon),
          binding: BindingsBuilder(() {
            if (!Get.isRegistered<RelatedPokemonsController>()) {
              Get.put(RelatedPokemonsController(Get.find<PokemonRepository>()));
            }
          }),
        );
      case '/related-pokemons':
        return GetPageRoute(
          page: () => const RelatedPokemonsPage(),
        );
      default:
        return GetPageRoute(
          page: () => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}

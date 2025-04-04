import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/route_names.dart';
import '../../../../core/presentation/routes/base_router.dart';
import '../../../pokemon_detail/presentation/bindings/pokemon_detail_binding.dart';
import '../../../pokemon_detail/presentation/pages/pokemon_detail_page.dart';
import '../../../pokemon_detail/presentation/pages/related_pokemons_page.dart';
import '../../../pokemon_list/presentation/bindings/pokemon_list_binding.dart';
import '../../../pokemon_list/presentation/pages/pokemon_list_page.dart';
import '../../../pokemon_list/presentation/pages/pokemon_search_page.dart';
import '../../domain/entities/pokemon_entity.dart';

class PokemonRouter extends BaseRouter {
  static const String pokemonSearch = '/pokemon/search';
  static const String pokemonDetail = '/pokemon/detail/:id';

  @override
  List<GetPage> get routes => [
        GetPage(
          name: RouteNames.pokemonList,
          page: () => const PokemonListPage(),
          binding: PokemonListBinding(),
        ),
        GetPage(
          name: pokemonDetail,
          page: () {
            final arguments = Get.arguments as Map<String, dynamic>?;
            final pokemon = arguments?['pokemon'] as PokemonEntity?;
            final id = int.parse(Get.parameters['id'] ?? '0');

            if (pokemon != null && pokemon.id == id) {
              return PokemonDetailPage(
                pokemon: pokemon,
                fromSearch: arguments?['fromSearch'] as bool? ?? false,
              );
            }

            // TODO: Implement loading Pokemon by ID if not provided in arguments
            return const Center(child: CircularProgressIndicator());
          },
          binding: PokemonDetailBinding(),
        ),
        GetPage(
          name: RouteNames.pokemonType,
          page: () {
            final arguments = Get.arguments as Map<String, dynamic>;
            return RelatedPokemonsPage(
              title: arguments['title'] as String,
              pokemons: (arguments['pokemons'] as List<dynamic>)
                  .cast<PokemonEntity>(),
            );
          },
          binding: PokemonDetailBinding(),
        ),
        GetPage(
          name: pokemonSearch,
          page: () => const PokemonSearchPage(),
          binding: PokemonListBinding(),
        ),
      ];
}

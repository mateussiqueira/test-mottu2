import 'package:get/get.dart';

import '../../../../core/constants/route_names.dart';
import '../../../../core/presentation/routes/base_router.dart';
import '../../domain/entities/pokemon_entity.dart';
import '../pages/pokemon_detail_page.dart';
import '../pages/pokemon_list_page.dart';
import '../pages/related_pokemons_page.dart';

class PokemonRouter extends BaseRouter {
  @override
  List<GetPage> get routes => [
        GetPage(
          name: RouteNames.pokemonList,
          page: () => const PokemonListPage(),
        ),
        GetPage(
          name: RouteNames.pokemonDetail,
          page: () {
            final pokemon = Get.arguments as PokemonEntity;
            return PokemonDetailPage(pokemon: pokemon);
          },
        ),
        GetPage(
          name: RouteNames.pokemonType,
          page: () {
            final arguments = Get.arguments as Map<String, dynamic>;
            return RelatedPokemonsPage(
              title: arguments['title'] as String,
              pokemons: arguments['pokemons'] as List<PokemonEntity>,
            );
          },
        ),
      ];
}

import 'package:get/get.dart';

import '../../../../core/constants/route_names.dart';
import '../../../../core/presentation/routes/base_router.dart';
import '../../../pokemon_detail/presentation/bindings/pokemon_detail_binding.dart';
import '../../../pokemon_detail/presentation/pages/pokemon_detail_page.dart';
import '../../../pokemon_detail/presentation/pages/related_pokemons_page.dart';
import '../../../pokemon_list/presentation/bindings/pokemon_list_binding.dart';
import '../../../pokemon_list/presentation/pages/pokemon_list_page.dart';
import '../../domain/entities/i_pokemon_entity.dart';

class PokemonRouter extends BaseRouter {
  @override
  List<GetPage> get routes => [
        GetPage(
          name: RouteNames.pokemonList,
          page: () => PokemonListPage(),
          binding: PokemonListBinding(),
        ),
        GetPage(
          name: RouteNames.pokemonDetail,
          page: () {
            final arguments = Get.arguments as Map<String, dynamic>;
            final pokemon = arguments['pokemon'] as IPokemonEntity;
            return PokemonDetailPage(
              pokemon: pokemon,
              fromSearch: arguments['fromSearch'] as bool? ?? false,
            );
          },
          binding: PokemonDetailBinding(),
        ),
        GetPage(
          name: RouteNames.pokemonType,
          page: () {
            final arguments = Get.arguments as Map<String, dynamic>;
            return RelatedPokemonsPage(
              title: arguments['title'] as String,
              pokemons: arguments['pokemons'] as List<IPokemonEntity>,
            );
          },
          binding: PokemonDetailBinding(),
        ),
      ];
}

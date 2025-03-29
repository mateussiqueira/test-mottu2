import 'package:get/get.dart';

import 'features/pokemon/domain/entities/pokemon_entity.dart';
import 'features/pokemon_detail/presentation/pages/pokemon_detail_page.dart';
import 'features/pokemon_list/presentation/pages/pokemon_list_page.dart';

class AppRouter {
  static const String pokemonList = '/pokemon-list';
  static const String pokemonDetail = '/pokemon-detail';

  static final List<GetPage> routes = [
    GetPage(
      name: pokemonList,
      page: () => PokemonListPage(repository: Get.find()),
    ),
    GetPage(
      name: pokemonDetail,
      page: () {
        final pokemon = Get.arguments as PokemonEntityImpl;
        return PokemonDetailPage(pokemon: pokemon);
      },
    ),
  ];
}

import 'package:get/get.dart';
import 'package:pokeapi/features/pokemon_list/domain/entities/pokemon.dart';

import 'features/pokemon_detail/presentation/pages/pokemon_detail_page.dart';
import 'features/pokemon_list/presentation/pages/pokemon_list_page.dart';

class AppRouter {
  static final List<GetPage> routes = [
    GetPage(
      name: '/pokemon-list',
      page: () => PokemonListPage(repository: Get.find()),
    ),
    GetPage(
      name: '/pokemon-detail',
      page: () {
        final pokemon = Get.arguments as PokemonEntity;
        return PokemonDetailPage(pokemon: pokemon);
      },
    ),
  ];
}

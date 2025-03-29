import 'package:get/get.dart';

import 'core/domain/entities/pokemon.dart';
import 'features/pokemon_detail/presentation/pages/pokemon_detail_page.dart';
import 'features/pokemon_list/presentation/pages/pokemon_list_page.dart';

class AppRouter {
  static final List<GetPage> routes = [
    GetPage(
      name: '/pokemon-list',
      page: () => const PokemonListPage(),
    ),
    GetPage(
      name: '/pokemon-detail',
      page: () {
        final pokemon = Get.arguments as Pokemon;
        return PokemonDetailPage(pokemon: pokemon);
      },
    ),
  ];
}

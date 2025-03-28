import 'package:get/get.dart';

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
      page: () => const PokemonDetailPage(),
    ),
  ];
}

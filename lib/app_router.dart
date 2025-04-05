
import 'package:get/get.dart';
import 'features/pokemon_list/presentation/pages/pokemon_list_page.dart';
import 'features/pokemon_detail/presentation/pages/pokemon_detail_page.dart';
import 'features/related_pokemons/presentation/pages/related_pokemons_page.dart';
import 'features/splash/presentation/pages/splash_page.dart';

class AppRouter {
  static final routes = [
    GetPage(
      name: '/',
      page: () => const SplashPage(),
    ),
    GetPage(
      name: '/pokemon-list',
      page: () => const PokemonListPage(),
    ),
    GetPage(
      name: '/pokemon-detail/:id',
      page: () => const PokemonDetailPage(),
    ),
    GetPage(
      name: '/related-pokemons/:type',
      page: () => const RelatedPokemonsPage(),
    ),
  ];
}

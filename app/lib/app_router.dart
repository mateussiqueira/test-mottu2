import 'package:get/get.dart';

import 'features/pokemon/domain/entities/pokemon_entity.dart';
import 'features/pokemon_detail/presentation/bindings/pokemon_detail_binding.dart';
import 'features/pokemon_detail/presentation/pages/pokemon_detail_page.dart';
import 'features/pokemon_list/presentation/pages/pokemon_list_page.dart';
import 'features/splash/presentation/pages/splash_page.dart';

/// Router configuration for the app
abstract class AppRouter {
  static const String initial = '/';
  static const String pokemonList = '/pokemon-list';
  static const String pokemonDetail = '/pokemon-detail';

  static final List<GetPage> routes = [
    GetPage(
      name: initial,
      page: () => const SplashPage(),
    ),
    GetPage(
      name: pokemonList,
      page: () => const PokemonListPage(),
    ),
    GetPage(
      name: pokemonDetail,
      binding: PokemonDetailBinding(),
      page: () {
        final args = Get.arguments as Map<String, dynamic>;
        return PokemonDetailPage(
          pokemon: args['pokemon'] as PokemonEntity,
          fromSearch: args['fromSearch'] as bool? ?? false,
        );
      },
    ),
  ];
}

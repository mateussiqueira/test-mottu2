import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/core/config/di.dart';

import '../../../features/pokemon/domain/entities/pokemon_entity.dart';
import '../../../features/pokemon_detail/domain/usecases/get_pokemon_by_id.dart';
import '../../../features/pokemon_detail/domain/usecases/get_pokemons_by_ability.dart';
import '../../../features/pokemon_detail/domain/usecases/get_pokemons_by_type.dart';
import '../../../features/pokemon_detail/presentation/controllers/pokemon_detail_controller.dart';
import '../../../features/pokemon_detail/presentation/pages/pokemon_detail_page.dart';
import '../../../features/pokemon_list/presentation/pages/pokemon_list_page.dart';
import '../../../features/splash/presentation/pages/splash_page.dart';

abstract class AppRouter {
  static const String initial = '/';
  static const String pokemonList = '/pokemon-list';
  static const String pokemonDetail = '/pokemon-detail';

  static List<GetPage> pages = [
    GetPage(
      name: initial,
      page: () => const SplashPage(),
    ),
    GetPage(
      name: pokemonList,
      page: () => PokemonListPage(),
    ),
    GetPage(
      name: pokemonDetail,
      page: () {
        final pokemon = Get.arguments as PokemonEntityImpl;
        if (Get.isRegistered<PokemonDetailController>()) {
          Get.delete<PokemonDetailController>();
        }

        Get.put(
          PokemonDetailController(
            getPokemonById: getIt<GetPokemonById>(),
            getPokemonsByType: getIt<GetPokemonsByType>(),
            getPokemonsByAbility: getIt<GetPokemonsByAbility>(),
          ),
        );

        return PokemonDetailPage(pokemon: pokemon);
      },
    ),
  ];

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initial:
        return GetPageRoute(
          page: () => const SplashPage(),
          settings: settings,
        );
      case pokemonList:
        return GetPageRoute(
          page: () => PokemonListPage(),
          settings: settings,
        );
      case pokemonDetail:
        final arguments = settings.arguments;
        if (arguments is PokemonEntityImpl) {
          if (Get.isRegistered<PokemonDetailController>()) {
            Get.delete<PokemonDetailController>();
          }

          Get.put(
            PokemonDetailController(
              getPokemonById: getIt<GetPokemonById>(),
              getPokemonsByType: getIt<GetPokemonsByType>(),
              getPokemonsByAbility: getIt<GetPokemonsByAbility>(),
            ),
          );

          return GetPageRoute(
            page: () => PokemonDetailPage(pokemon: arguments),
            settings: settings,
          );
        } else {
          return _errorRoute(
            'Argumento inválido para a rota $pokemonDetail. Esperado: PokemonEntity.',
          );
        }
      default:
        return _errorRoute('Rota não definida para ${settings.name}');
    }
  }

  static Route<dynamic> _errorRoute(String message) {
    return GetPageRoute(
      page: () => Scaffold(
        body: Center(
          child: Text(
            message,
            style: const TextStyle(fontSize: 18, color: Colors.red),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

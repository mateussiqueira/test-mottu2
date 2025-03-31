import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../features/pokemon/domain/entities/pokemon_entity.dart';
import '../../../features/pokemon_detail/presentation/pages/pokemon_detail_page.dart';
import '../../../features/pokemon_list/domain/repositories/pokemon_repository.dart'
    as pokemon_list;
import '../../../features/pokemon_list/presentation/pages/pokemon_list_page.dart';
import '../../presentation/pages/splash_page.dart';

class AppRouter {
  static const String splash = '/';
  static const String pokemonList = '/pokemon-list';
  static const String pokemonDetail = '/pokemon-detail';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return GetPageRoute(
          page: () => const SplashPage(),
          settings: settings,
        );
      case pokemonList:
        return GetPageRoute(
          page: () => PokemonListPage(
              repository: Get.find<pokemon_list.PokemonRepository>()),
          settings: settings,
        );
      case pokemonDetail:
        // Verifica se o argumento é do tipo esperado
        final arguments = settings.arguments;
        if (arguments is PokemonEntityImpl) {
          return GetPageRoute(
            page: () => PokemonDetailPage(pokemon: arguments),
            settings: settings,
          );
        } else {
          return _errorRoute(
            'Argumento inválido para a rota $pokemonDetail. Esperado: PokemonEntityImpl.',
          );
        }
      default:
        return _errorRoute('Rota não definida para ${settings.name}');
    }
  }

  // Método auxiliar para rotas de erro
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

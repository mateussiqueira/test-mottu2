import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../features/pokemon/presentation/routes/pokemon_router.dart';
import 'i_router.dart';

class AppRouter implements IRouter {
  final PokemonRouter _pokemonRouter;

  AppRouter(this._pokemonRouter);

  @override
  List<GetPage> get routes => _pokemonRouter.routes;

  @override
  Route<dynamic> generateRoute(RouteSettings settings) {
    return _pokemonRouter.generateRoute(settings);
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/data/adapters/poke_api_adapter.dart';
import 'core/data/repositories/pokemon_repository_impl.dart';
import 'core/domain/entities/pokemon.dart';
import 'core/domain/repositories/pokemon_repository.dart';
import 'features/pokemon_detail/presentation/pages/pokemon_detail_page.dart';
import 'features/pokemon_list/presentation/controllers/pokemon_list_controller.dart';
import 'features/pokemon_list/presentation/controllers/related_pokemons_controller.dart';
import 'features/pokemon_list/presentation/pages/pokemon_list_page.dart';
import 'features/pokemon_list/presentation/pages/related_pokemons_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Pokédex',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      getPages: [
        GetPage(
          name: '/',
          page: () => const PokemonListPage(),
          binding: BindingsBuilder(() {
            final repository = PokemonRepositoryImpl(PokeApiAdapter());
            Get.put<PokemonRepository>(repository);
            Get.put(PokemonListController(repository));
          }),
        ),
        GetPage(
          name: '/pokemon-detail',
          page: () => PokemonDetailPage(
            pokemon: Get.arguments as Pokemon,
          ),
        ),
        GetPage(
          name: '/related-pokemons',
          page: () => const RelatedPokemonsPage(),
          binding: BindingsBuilder(() {
            Get.put(RelatedPokemonsController(Get.find<PokemonRepository>()));
          }),
        ),
      ],
      initialRoute: '/',
    );
  }
}

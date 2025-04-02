import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../features/pokemon/domain/entities/i_pokemon_entity.dart';
import '../controllers/i_pokemon_list_controller.dart';
import '../controllers/i_pokemon_search_controller.dart';
import '../widgets/pokemon_grid.dart';
import '../widgets/pokemon_list_error.dart';
import '../widgets/pokemon_list_loading.dart';
import '../widgets/pokemon_search_delegate.dart';

/// Page for displaying the list of Pokemon
class PokemonListPage extends StatelessWidget {
  const PokemonListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final listController = Get.find<IPokemonListController>();
    final searchController = Get.find<IPokemonSearchController>();

    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0,
        title: const Text(
          'Pokédex',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              showSearch<IPokemonEntity?>(
                context: context,
                delegate: PokemonSearchDelegate(searchController),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: Obx(() {
            if (listController.isLoading && listController.pokemons.isEmpty) {
              return const PokemonListLoading();
            }

            if (listController.error?.isNotEmpty ?? false) {
              return PokemonListError(
                message: listController.error ?? 'Unknown error',
                onRetry: () => listController.fetchPokemonList(),
              );
            }

            return RefreshIndicator(
              onRefresh: () => listController.fetchPokemonList(),
              child: PokemonGrid(
                pokemons: listController.pokemons,
                hasMore: listController.hasMore,
                onLoadMore: listController.loadMorePokemons,
                isLoading: listController.isLoading,
              ),
            );
          }),
        ),
      ),
    );
  }
}

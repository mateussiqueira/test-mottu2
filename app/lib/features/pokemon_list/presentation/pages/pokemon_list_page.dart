import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokemon_list/features/pokemon_list/presentation/controllers/pokemon_list_controller.dart';
import 'package:pokemon_list/features/pokemon_list/presentation/widgets/pokemon_card.dart';
import 'package:pokemon_list/features/pokemon_list/presentation/widgets/pokemon_search_delegate.dart';
import 'package:pokemon_list/features/pokemon_list/presentation/widgets/pokemon_shimmer_card.dart';

/// Page for displaying the list of Pokemon
class PokemonListPage extends GetView<PokemonListController> {
  const PokemonListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokémon List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: PokemonSearchDelegate(controller),
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: controller.fetchPokemonList,
        child: Obx(() {
          if (controller.state.isLoading.value) {
            return ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) => const PokemonShimmerCard(),
            );
          }

          if (controller.state.error.value.isNotEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(controller.state.error.value),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: controller.fetchPokemonList,
                    child: const Text('Try Again'),
                  ),
                ],
              ),
            );
          }

          final pokemons = controller.state.pokemons;
          if (pokemons.isEmpty) {
            return const Center(child: Text('No Pokémon found'));
          }

          return ListView.builder(
            controller: controller.scrollController,
            itemCount:
                pokemons.length + (controller.state.hasMore.value ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == pokemons.length) {
                return const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: PokemonShimmerCard(),
                );
              }

              final pokemon = pokemons[index];
              return PokemonCard(
                pokemon: pokemon,
                onTap: () => controller.navigateToDetail(pokemon),
              );
            },
          );
        }),
      ),
    );
  }
}

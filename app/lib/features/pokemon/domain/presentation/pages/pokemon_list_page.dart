import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokemon_list/features/pokemon/domain/presentation/controllers/pokemon_list_controller.dart';
import 'package:pokemon_list/features/pokemon/domain/presentation/widgets/pokemon_card.dart';
import 'package:pokemon_list/features/pokemon/domain/presentation/widgets/pokemon_list_error.dart';
import 'package:pokemon_list/features/pokemon/domain/presentation/widgets/pokemon_list_loading.dart';
import 'package:pokemon_list/features/pokemon/domain/presentation/widgets/pokemon_search_bar.dart';

/// Page that displays a grid of Pokemon
class PokemonListPage extends GetView<PokemonListController> {
  const PokemonListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokemon List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => showSearch(
              context: context,
              delegate: PokemonSearchDelegate(controller: controller),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const PokemonSearchBar(),
          Expanded(
            child: Obx(() {
              if (controller.isLoading && controller.pokemons.isEmpty) {
                return const PokemonListLoading();
              }

              if (controller.error != null) {
                return PokemonListError(
                  error: controller.error!,
                  onRetry: () {
                    controller.clearError();
                    controller.loadPokemons();
                  },
                );
              }

              return NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  if (notification is ScrollEndNotification &&
                      notification.metrics.pixels ==
                          notification.metrics.maxScrollExtent &&
                      controller.hasMore) {
                    controller.loadPokemons();
                  }
                  return true;
                },
                child: GridView.builder(
                  padding: const EdgeInsets.all(8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount:
                      controller.pokemons.length + (controller.hasMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == controller.pokemons.length) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    final pokemon = controller.pokemons[index];
                    return PokemonCard(
                      pokemon: pokemon,
                      onTap: () => controller.navigateToDetail(pokemon),
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

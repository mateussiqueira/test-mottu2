import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/domain/entities/pokemon.dart';
import '../controllers/pokemon_list_controller.dart';
import '../widgets/pokemon_skeleton_card.dart';

class PokemonListPage extends GetView<PokemonListController> {
  const PokemonListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          if (controller.pokemons.length == 1) {
            return Text(controller.pokemons.first.name.toUpperCase());
          }
          if (controller.filterType.isNotEmpty) {
            return Text('${controller.filterType.toUpperCase()} POKÉMON');
          }
          if (controller.filterAbility.isNotEmpty) {
            return Text('${controller.filterAbility.toUpperCase()} POKÉMON');
          }
          return const Text('POKÉDEX');
        }),
        actions: [
          Obx(() {
            if (controller.filterType.isNotEmpty ||
                controller.filterAbility.isNotEmpty ||
                controller.searchQuery.isNotEmpty) {
              return IconButton(
                icon: const Icon(Icons.clear),
                onPressed: controller.clearFilters,
              );
            }
            return const SizedBox.shrink();
          }),
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
      body: Obx(() {
        if (controller.isLoading.value && controller.pokemons.isEmpty) {
          return _buildSkeletonGrid();
        }

        if (controller.error.isNotEmpty && controller.pokemons.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(controller.error.value),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => controller.loadPokemons(refresh: true),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () => controller.loadPokemons(refresh: true),
          child: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is ScrollEndNotification &&
                  notification.metrics.pixels >=
                      notification.metrics.maxScrollExtent - 200) {
                controller.loadMore();
              }
              return false;
            },
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: controller.pokemons.length +
                  (controller.isLoading.value ? 2 : 0),
              itemBuilder: (context, index) {
                if (index >= controller.pokemons.length) {
                  return const PokemonSkeletonCard();
                }
                final pokemon = controller.pokemons[index];
                return PokemonCard(pokemon: pokemon);
              },
            ),
          ),
        );
      }),
    );
  }

  Widget _buildSkeletonGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: 6,
      itemBuilder: (context, index) => const PokemonSkeletonCard(),
    );
  }
}

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonCard({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          '/pokemon-detail',
          arguments: pokemon,
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(16)),
                    child: Image.network(
                      pokemon.imageUrl,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  if (pokemon.types.isNotEmpty)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          pokemon.types.first,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(16)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pokemon.name,
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '#${pokemon.id.toString().padLeft(3, '0')}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PokemonSearchDelegate extends SearchDelegate<void> {
  final PokemonListController controller;

  PokemonSearchDelegate(this.controller);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return const Center(child: Text('Type a Pokémon name'));
    }

    controller.searchPokemon(query);

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.error.isNotEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(controller.error.value),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => controller.searchPokemon(query),
                child: const Text('Retry'),
              ),
            ],
          ),
        );
      }

      if (controller.pokemons.isEmpty) {
        return const Center(child: Text('No Pokémon found'));
      }

      return ListView.builder(
        itemCount: controller.pokemons.length,
        itemBuilder: (context, index) {
          final pokemon = controller.pokemons[index];
          return ListTile(
            leading: Image.network(
              pokemon.imageUrl,
              width: 50,
              height: 50,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.error),
            ),
            title: Text(pokemon.name),
            subtitle: Text('#${pokemon.id.toString().padLeft(3, '0')}'),
            onTap: () {
              Get.toNamed(
                '/pokemon-detail',
                arguments: pokemon,
              );
              close(context, null);
            },
          );
        },
      );
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildResults(context);
  }
}

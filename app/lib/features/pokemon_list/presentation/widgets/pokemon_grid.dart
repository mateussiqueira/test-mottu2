import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../features/pokemon/domain/entities/pokemon_entity.dart';
import '../../../../features/pokemon/presentation/routes/pokemon_router.dart';
import 'pokemon_card.dart';

/// Widget for displaying a grid of Pokemon
class PokemonGrid extends StatelessWidget {
  final RxList<PokemonEntity> pokemons;
  final bool hasMore;
  final VoidCallback onLoadMore;
  final bool fromSearch;

  const PokemonGrid({
    super.key,
    required this.pokemons,
    required this.hasMore,
    required this.onLoadMore,
    this.fromSearch = false,
  });

  void _navigateToDetail(PokemonEntity pokemon) {
    Get.toNamed(
      PokemonRouter.pokemonDetail.replaceAll(':id', pokemon.id.toString()),
      arguments: {
        'pokemon': pokemon,
        'fromSearch': fromSearch,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollInfo) {
        if (!hasMore || scrollInfo is! ScrollUpdateNotification) return false;

        const threshold = 0.8;
        final currentPosition = scrollInfo.metrics.pixels;
        final maxPosition = scrollInfo.metrics.maxScrollExtent;

        if (currentPosition >= maxPosition * threshold) {
          onLoadMore();
        }
        return false;
      },
      child: Obx(
        () => GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.75,
          ),
          itemCount: pokemons.length + (hasMore ? 1 : 0),
          itemBuilder: (context, index) {
            if (index < pokemons.length) {
              final pokemon = pokemons[index];
              return PokemonCard(
                pokemon: pokemon,
                onTap: () => _navigateToDetail(pokemon),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}

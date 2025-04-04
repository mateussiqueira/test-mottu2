import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/i_pokemon_entity.dart';
import '../providers/pokemon_provider.dart';
import 'pokemon_card_widget.dart';

/// Widget that displays a list of Pokemon
class PokemonListWidget extends ConsumerWidget {
  final int? limit;
  final int? offset;

  const PokemonListWidget({
    super.key,
    this.limit,
    this.offset,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemonList = ref.watch(
      pokemonListProvider((limit: limit, offset: offset)),
    );

    return pokemonList.when(
      data: (List<IPokemonEntity> pokemons) {
        if (pokemons.isEmpty) {
          return const Center(
            child: Text('No Pokémon found'),
          );
        }

        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: pokemons.length,
          itemBuilder: (context, index) {
            final pokemon = pokemons[index];
            return PokemonCardWidget(pokemon: pokemon);
          },
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stackTrace) => Center(
        child: Text('Error: $error'),
      ),
    );
  }
}

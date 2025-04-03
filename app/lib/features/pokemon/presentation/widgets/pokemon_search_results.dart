import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/i_pokemon_entity.dart';
import '../../domain/entities/pokemon_entity.dart';
import '../providers/pokemon_provider.dart';
import 'pokemon_card_widget.dart';

/// Widget that displays Pokemon search results
class PokemonSearchResults extends ConsumerWidget {
  final String query;

  const PokemonSearchResults({
    super.key,
    required this.query,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchResults = ref.watch(searchPokemonProvider(query));

    return searchResults.when(
      data: (List<PokemonEntity> pokemons) {
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
            final pokemon = pokemons[index] as IPokemonEntity;
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

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/i_pokemon_entity.dart';
import '../providers/pokemon_provider.dart';
import 'pokemon_card_widget.dart';

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
    final pokemonListAsync = ref.watch(
      pokemonListProvider((limit: limit, offset: offset)),
    );

    return pokemonListAsync.when(
      data: (pokemons) {
        if (pokemons.isEmpty) {
          return const Center(
            child: Text('No Pokemon found'),
          );
        }

        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: pokemons.length,
          padding: const EdgeInsets.all(10),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 60,
            ),
            const SizedBox(height: 16),
            Text(
              error.toString(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ref.invalidate(pokemonListProvider);
              },
              child: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }
}

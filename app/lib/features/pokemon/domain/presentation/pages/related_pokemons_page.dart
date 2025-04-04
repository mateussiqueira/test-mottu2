import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/i_pokemon_entity.dart';
import '../bloc/pokemon_bloc.dart';
import '../widgets/pokemon_card.dart';

/// Page that displays related Pokemon
class RelatedPokemonsPage extends StatelessWidget {
  const RelatedPokemonsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pokemon =
        ModalRoute.of(context)!.settings.arguments as IPokemonEntity;

    return Scaffold(
      appBar: AppBar(
        title: Text('Related to ${pokemon.name}'),
      ),
      body: BlocBuilder<PokemonBloc, PokemonState>(
        builder: (context, state) {
          if (state is PokemonLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is PokemonError) {
            return Center(child: Text(state.message));
          }

          if (state is PokemonListLoaded) {
            return GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: state.pokemons.length,
              itemBuilder: (context, index) {
                final relatedPokemon = state.pokemons[index];
                return PokemonCard(pokemon: relatedPokemon);
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

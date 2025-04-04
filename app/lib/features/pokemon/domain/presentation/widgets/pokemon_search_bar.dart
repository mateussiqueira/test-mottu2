import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/pokemon_bloc.dart';

/// Widget that displays a search bar for Pokemon
class PokemonSearchBar extends StatelessWidget {
  const PokemonSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SearchBar(
        hintText: 'Search Pokemon...',
        leading: const Icon(Icons.search),
        trailing: [
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              context.read<PokemonBloc>().add(
                    const SearchPokemon(''),
                  );
            },
          ),
        ],
        onSubmitted: (query) {
          context.read<PokemonBloc>().add(
                SearchPokemon(query),
              );
        },
      ),
    );
  }
}

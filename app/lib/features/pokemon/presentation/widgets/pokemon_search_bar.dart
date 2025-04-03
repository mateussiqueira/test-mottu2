import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/pokemon_bloc.dart';

class PokemonSearchBar extends StatelessWidget {
  const PokemonSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SearchBar(
        hintText: 'Search Pokemon...',
        onSubmitted: (query) {
          if (query.isNotEmpty) {
            context.read<PokemonBloc>().add(SearchPokemon(query));
          }
        },
        trailing: [
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              context.read<PokemonBloc>().add(
                    const GetPokemonList(limit: 20, offset: 0),
                  );
            },
          ),
        ],
      ),
    );
  }
}

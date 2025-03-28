import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/pokemon_list_bloc.dart';

class PokemonSearchDelegate extends SearchDelegate<String> {
  final PokemonListBloc bloc;

  PokemonSearchDelegate(this.bloc);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          bloc.add(const LoadPokemons());
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
        bloc.add(const LoadPokemons());
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return const Center(
        child: Text('Digite para buscar Pokémon'),
      );
    }

    bloc.add(SearchPokemon(query));
    return _buildSearchResults();
  }

  String _getImageUrl(pokemon) =>
      pokemon.sprites['other']?['official-artwork']?['front_default'] ?? '';

  List<String> _getTypes(pokemon) => pokemon.types
      .map((type) => type['type']?['name'] as String? ?? '')
      .where((type) => type.isNotEmpty)
      .toList();

  Widget _buildSearchResults() {
    return BlocBuilder<PokemonListBloc, PokemonListState>(
      bloc: bloc,
      builder: (context, state) {
        if (state is PokemonListLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is PokemonListError) {
          return Center(
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
                  state.message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          );
        }

        if (state is PokemonListLoaded) {
          if (state.pokemons.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.search_off,
                    size: 60,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Nenhum Pokémon encontrado para "$query"',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: state.pokemons.length,
            itemBuilder: (context, index) {
              final pokemon = state.pokemons[index];
              return ListTile(
                leading: Image.network(
                  _getImageUrl(pokemon),
                  width: 50,
                  height: 50,
                  fit: BoxFit.contain,
                ),
                title: Text(
                  pokemon.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  _getTypes(pokemon).join(', '),
                  style: const TextStyle(fontSize: 14),
                ),
                onTap: () {
                  close(context, pokemon.name);
                },
              );
            },
          );
        }

        return const Center(
          child: Text('Digite para buscar Pokémon'),
        );
      },
    );
  }
}

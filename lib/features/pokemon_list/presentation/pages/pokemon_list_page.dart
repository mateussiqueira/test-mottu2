import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/data/adapters/poke_api_adapter.dart';
import '../../../../core/data/repositories/pokemon_repository_impl.dart';
import '../bloc/pokemon_list_bloc.dart';
import '../widgets/pokemon_grid.dart';

class PokemonListPage extends StatelessWidget {
  const PokemonListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        }

        final prefs = snapshot.data!;
        final client = http.Client();

        return BlocProvider(
          create: (context) {
            final repository = PokemonRepositoryImpl(
              PokeApiAdapter(
                client: client,
                prefs: prefs,
              ),
            );
            return PokemonListBloc(repository: repository)
              ..add(const LoadPokemons());
          },
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Pokédex'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: PokemonSearchDelegate(),
                    );
                  },
                ),
              ],
            ),
            body: const PokemonGrid(),
          ),
        );
      },
    );
  }
}

class PokemonSearchDelegate extends SearchDelegate<String> {
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
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults(context);
  }

  Widget _buildSearchResults(BuildContext context) {
    if (query.isEmpty) {
      return const Center(
        child: Text('Enter a Pokémon name to search'),
      );
    }

    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        final prefs = snapshot.data!;
        final client = http.Client();

        return BlocProvider(
          create: (context) {
            final repository = PokemonRepositoryImpl(
              PokeApiAdapter(
                client: client,
                prefs: prefs,
              ),
            );
            final bloc = PokemonListBloc(repository: repository);
            bloc.add(SearchPokemon(query));
            return bloc;
          },
          child: BlocBuilder<PokemonListBloc, PokemonListState>(
            builder: (context, state) {
              if (state is PokemonListLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is PokemonListError) {
                return Center(
                  child: Text(state.message),
                );
              }

              if (state is PokemonListLoaded) {
                final pokemons = state.pokemons;
                if (pokemons.isEmpty) {
                  return const Center(
                    child: Text('No Pokémon found'),
                  );
                }

                return ListView.builder(
                  itemCount: pokemons.length,
                  itemBuilder: (context, index) {
                    final pokemon = pokemons[index];
                    return ListTile(
                      leading: Image.network(
                        pokemon.imageUrl,
                        width: 50,
                        height: 50,
                      ),
                      title: Text(pokemon.name),
                      onTap: () {
                        Get.toNamed('/pokemon-detail', arguments: pokemon);
                      },
                    );
                  },
                );
              }

              return const SizedBox.shrink();
            },
          ),
        );
      },
    );
  }
}

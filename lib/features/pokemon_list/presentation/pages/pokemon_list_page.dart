import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/data/adapters/poke_api_adapter.dart';
import '../../../../core/data/repositories/pokemon_repository_impl.dart';
import '../bloc/pokemon_list_bloc.dart';
import '../widgets/pokemon_grid.dart';
import '../widgets/pokemon_search_delegate.dart';

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
                      delegate: PokemonSearchDelegate(
                        context.read<PokemonListBloc>(),
                      ),
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

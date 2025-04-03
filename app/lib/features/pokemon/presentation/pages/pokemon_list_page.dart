import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/pokemon_bloc.dart';
import '../widgets/pokemon_card.dart';
import '../widgets/pokemon_filter_dialog.dart';
import '../widgets/pokemon_search_bar.dart';

/// Page that displays a grid of Pokemon
class PokemonListPage extends StatefulWidget {
  const PokemonListPage({super.key});

  @override
  State<PokemonListPage> createState() => _PokemonListPageState();
}

class _PokemonListPageState extends State<PokemonListPage> {
  final _scrollController = ScrollController();
  int _currentPage = 0;
  static const _itemsPerPage = 20;

  @override
  void initState() {
    super.initState();
    _loadPokemons();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _loadPokemons() {
    context.read<PokemonBloc>().add(
          GetPokemonList(
            limit: _itemsPerPage,
            offset: _currentPage * _itemsPerPage,
          ),
        );
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _currentPage++;
      _loadPokemons();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PokeAPI'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(context),
          ),
        ],
      ),
      body: Column(
        children: [
          const PokemonSearchBar(),
          Expanded(
            child: BlocBuilder<PokemonBloc, PokemonState>(
              builder: (context, state) {
                if (state is PokemonInitial) {
                  return const Center(child: Text('Search for Pokemon'));
                }

                if (state is PokemonLoading && _currentPage == 0) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is PokemonError) {
                  return Center(child: Text(state.message));
                }

                if (state is PokemonLoaded) {
                  return GridView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(8),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: state.pokemons.length +
                        (state is PokemonLoading ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index >= state.pokemons.length) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      final pokemon = state.pokemons[index];
                      return PokemonCard(pokemon: pokemon);
                    },
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const PokemonFilterDialog(),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../../features/pokemon/domain/entities/i_pokemon_entity.dart';
import 'pokemon_grid_item.dart';

/// Widget for displaying a grid of Pokemon
class PokemonGrid extends StatefulWidget {
  final List<IPokemonEntity> pokemons;
  final bool hasMore;
  final bool isLoading;
  final VoidCallback? onLoadMore;

  const PokemonGrid({
    super.key,
    required this.pokemons,
    required this.hasMore,
    this.isLoading = false,
    this.onLoadMore,
  });

  @override
  State<PokemonGrid> createState() => _PokemonGridState();
}

class _PokemonGridState extends State<PokemonGrid> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    if (widget.hasMore) {
      _scrollController.addListener(_onScroll);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      widget.onLoadMore?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: widget.hasMore ? _scrollController : null,
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount:
          widget.pokemons.length + (widget.hasMore && widget.isLoading ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == widget.pokemons.length) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
            ),
          );
        }

        final pokemon = widget.pokemons[index];
        return Hero(
          tag: 'pokemon-${pokemon.id}',
          child: PokemonGridItem(pokemon: pokemon),
        );
      },
    );
  }
}

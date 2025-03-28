import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_constants.dart';
import '../bloc/pokemon_list_bloc.dart';
import 'pokemon_grid_item.dart';

class PokemonGrid extends StatelessWidget {
  const PokemonGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonListBloc, PokemonListState>(
      builder: (context, state) {
        if (state is PokemonListLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is PokemonListError) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(
                fontSize: AppConstants.bodyLargeSize,
                color: Colors.red,
              ),
            ),
          );
        }

        if (state is PokemonListLoaded) {
          return GridView.builder(
            padding: const EdgeInsets.all(AppConstants.spacingLarge),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: AppConstants.gridCrossAxisCount,
              childAspectRatio: AppConstants.gridChildAspectRatio,
              crossAxisSpacing: AppConstants.gridSpacing,
              mainAxisSpacing: AppConstants.gridSpacing,
            ),
            itemCount: state.pokemons.length,
            itemBuilder: (context, index) {
              return PokemonGridItem(pokemon: state.pokemons[index]);
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

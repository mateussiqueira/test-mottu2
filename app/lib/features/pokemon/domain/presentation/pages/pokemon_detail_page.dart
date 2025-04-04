import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/i_pokemon_entity.dart';
import '../bloc/pokemon_bloc.dart';
import '../widgets/pokemon_detail_error.dart';
import '../widgets/pokemon_detail_loading.dart';

/// Page that displays detailed information about a Pokemon
class PokemonDetailPage extends StatelessWidget {
  const PokemonDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pokemon =
        ModalRoute.of(context)!.settings.arguments as IPokemonEntity;

    return Scaffold(
      appBar: AppBar(
        title: Text(pokemon.name),
      ),
      body: BlocBuilder<PokemonBloc, PokemonState>(
        builder: (context, state) {
          if (state is PokemonLoading) {
            return const PokemonDetailLoading();
          }

          if (state is PokemonError) {
            return PokemonDetailError(
              message: state.message,
              onRetry: () => context.read<PokemonBloc>().add(
                    GetPokemonById(pokemon.id),
                  ),
            );
          }

          if (state is PokemonDetailLoaded) {
            final pokemon = state.pokemon;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.network(
                      pokemon.imageUrl,
                      height: 200,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Types:',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Wrap(
                    spacing: 8,
                    children: pokemon.types
                        .map(
                          (type) => Chip(
                            label: Text(type),
                            backgroundColor: _getTypeColor(type),
                            labelStyle: const TextStyle(color: Colors.white),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Abilities:',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Wrap(
                    spacing: 8,
                    children: pokemon.abilities
                        .map(
                          (ability) => Chip(
                            label: Text(ability),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Stats:',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  ...pokemon.stats.entries.map(
                    (stat) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(stat.key),
                          ),
                          Expanded(
                            flex: 2,
                            child: LinearProgressIndicator(
                              value: stat.value / 255,
                              backgroundColor: Colors.grey[200],
                              valueColor: AlwaysStoppedAnimation<Color>(
                                _getStatColor(stat.value),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(stat.value.toString()),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'normal':
        return Colors.brown.shade400;
      case 'fire':
        return Colors.red;
      case 'water':
        return Colors.blue;
      case 'electric':
        return Colors.amber;
      case 'grass':
        return Colors.green;
      case 'ice':
        return Colors.cyan;
      case 'fighting':
        return Colors.deepOrange;
      case 'poison':
        return Colors.purple;
      case 'ground':
        return Colors.brown;
      case 'flying':
        return Colors.indigo;
      case 'psychic':
        return Colors.pink;
      case 'bug':
        return Colors.lightGreen;
      case 'rock':
        return Colors.grey;
      case 'ghost':
        return Colors.deepPurple;
      case 'dragon':
        return Colors.indigo;
      case 'dark':
        return Colors.black87;
      case 'steel':
        return Colors.blueGrey;
      case 'fairy':
        return Colors.pinkAccent;
      default:
        return Colors.grey;
    }
  }

  Color _getStatColor(int value) {
    if (value >= 200) return Colors.green;
    if (value >= 150) return Colors.lightGreen;
    if (value >= 100) return Colors.yellow;
    if (value >= 50) return Colors.orange;
    return Colors.red;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/related_pokemons_bloc.dart';

class RelatedPokemonsPage extends StatelessWidget {
  const RelatedPokemonsPage({super.key});

  String _getImageUrl(pokemon) =>
      pokemon.sprites['other']?['official-artwork']?['front_default'] ?? '';

  List<String> _getTypes(pokemon) => pokemon.types
      .map((type) => type['type']?['name'] as String? ?? '')
      .where((type) => type.isNotEmpty)
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<RelatedPokemonsBloc, RelatedPokemonsState>(
          builder: (context, state) {
            if (state is RelatedPokemonsLoaded) {
              if (state.filterType != null) {
                return Text('${state.filterType!.toUpperCase()} POKÉMON');
              }
              if (state.filterAbility != null) {
                return Text('${state.filterAbility!.toUpperCase()} POKÉMON');
              }
            }
            return const Text('POKÉMON RELACIONADOS');
          },
        ),
      ),
      body: BlocBuilder<RelatedPokemonsBloc, RelatedPokemonsState>(
        builder: (context, state) {
          if (state is RelatedPokemonsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is RelatedPokemonsError) {
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

          if (state is RelatedPokemonsLoaded) {
            if (state.pokemons.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 60,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Nenhum Pokémon encontrado',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              );
            }

            return GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: state.pokemons.length,
              itemBuilder: (context, index) {
                final pokemon = state.pokemons[index];
                return Card(
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.network(
                          _getImageUrl(pokemon),
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.error_outline,
                              color: Colors.red,
                              size: 48,
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              pokemon.name.toUpperCase(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 4,
                              children: _getTypes(pokemon)
                                  .map((type) => Chip(
                                        label: Text(
                                          type.toUpperCase(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                        backgroundColor: _getTypeColor(type),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }

          return const Center(
            child: Text('Selecione um tipo ou habilidade'),
          );
        },
      ),
    );
  }

  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'grass':
        return Colors.green;
      case 'fire':
        return Colors.red;
      case 'water':
        return Colors.blue;
      case 'electric':
        return Colors.yellow;
      case 'psychic':
        return Colors.purple;
      case 'ice':
        return Colors.lightBlue;
      case 'dragon':
        return Colors.indigo;
      case 'dark':
        return Colors.brown;
      case 'fairy':
        return Colors.pink;
      case 'normal':
        return Colors.grey;
      case 'fighting':
        return Colors.orange;
      case 'flying':
        return Colors.indigo;
      case 'poison':
        return Colors.purple;
      case 'ground':
        return Colors.brown;
      case 'rock':
        return Colors.grey;
      case 'bug':
        return Colors.lightGreen;
      case 'ghost':
        return Colors.deepPurple;
      case 'steel':
        return Colors.blueGrey;
      default:
        return Colors.grey;
    }
  }
}

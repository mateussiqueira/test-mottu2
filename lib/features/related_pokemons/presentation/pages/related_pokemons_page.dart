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
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: () {
                      // TODO: Navegar para a página de detalhes
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Image.network(
                            _getImageUrl(pokemon),
                            fit: BoxFit.contain,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                pokemon.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Wrap(
                                spacing: 4,
                                children: _getTypes(pokemon).map((type) {
                                  return Chip(
                                    label: Text(
                                      type,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                    backgroundColor: _getTypeColor(type),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          return const Center(
            child: Text('Carregando Pokémon...'),
          );
        },
      ),
    );
  }

  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'normal':
        return Colors.grey;
      case 'fire':
        return Colors.red;
      case 'water':
        return Colors.blue;
      case 'electric':
        return Colors.yellow;
      case 'grass':
        return Colors.green;
      case 'ice':
        return Colors.lightBlue;
      case 'fighting':
        return Colors.brown;
      case 'poison':
        return Colors.purple;
      case 'ground':
        return Colors.brown[300]!;
      case 'flying':
        return Colors.indigo;
      case 'psychic':
        return Colors.pink;
      case 'bug':
        return Colors.lightGreen;
      case 'rock':
        return Colors.grey[700]!;
      case 'ghost':
        return Colors.deepPurple;
      case 'dragon':
        return Colors.indigo[700]!;
      case 'dark':
        return Colors.grey[900]!;
      case 'steel':
        return Colors.blueGrey;
      case 'fairy':
        return Colors.pink[200]!;
      default:
        return Colors.grey;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../features/pokemon/domain/entities/pokemon_entity.dart';

/// Widget for displaying a Pokemon card
class PokemonCard extends StatelessWidget {
  final PokemonEntity pokemon;
  final VoidCallback onTap;

  const PokemonCard({
    Key? key,
    required this.pokemon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.network(
                    pokemon.imageUrl,
                    height: 100,
                    width: 100,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          pokemon.name.capitalizeFirst!,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          children: pokemon.types
                              .map((type) => Chip(
                                    label: Text(type.capitalizeFirst!),
                                    backgroundColor: _getTypeColor(type),
                                  ))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (pokemon.typeRelations != null) ...[
                Text(
                  'Type Relations:',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                _buildTypeRelations(context),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTypeRelations(BuildContext context) {
    final relations = pokemon.typeRelations;
    if (relations == null) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (relations.doubleDamageTo.isNotEmpty) ...[
          const Text('Double Damage To:'),
          Wrap(
            spacing: 8,
            children: relations.doubleDamageTo
                .map((type) => Chip(
                      label: Text(type.capitalizeFirst!),
                      backgroundColor: _getTypeColor(type),
                    ))
                .toList(),
          ),
        ],
        if (relations.doubleDamageFrom.isNotEmpty) ...[
          const Text('Double Damage From:'),
          Wrap(
            spacing: 8,
            children: relations.doubleDamageFrom
                .map((type) => Chip(
                      label: Text(type.capitalizeFirst!),
                      backgroundColor: _getTypeColor(type),
                    ))
                .toList(),
          ),
        ],
      ],
    );
  }

  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'normal':
        return const Color(0xFFA8A878);
      case 'fire':
        return const Color(0xFFF08030);
      case 'water':
        return const Color(0xFF6890F0);
      case 'electric':
        return const Color(0xFFF8D030);
      case 'grass':
        return const Color(0xFF78C850);
      case 'ice':
        return const Color(0xFF98D8D8);
      case 'fighting':
        return const Color(0xFFC03028);
      case 'poison':
        return const Color(0xFFA040A0);
      case 'ground':
        return const Color(0xFFE0C068);
      case 'flying':
        return const Color(0xFFA890F0);
      case 'psychic':
        return const Color(0xFFF85888);
      case 'bug':
        return const Color(0xFFA8B820);
      case 'rock':
        return const Color(0xFFB8A038);
      case 'ghost':
        return const Color(0xFF705898);
      case 'dragon':
        return const Color(0xFF7038F8);
      case 'dark':
        return const Color(0xFF705848);
      case 'steel':
        return const Color(0xFFB8B8D0);
      case 'fairy':
        return const Color(0xFFEE99AC);
      default:
        return const Color(0xFFA8A878);
    }
  }
}

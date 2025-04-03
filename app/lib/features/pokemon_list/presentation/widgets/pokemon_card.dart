import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokemon_list/features/pokemon_list/domain/entities/pokemon_entity.dart';

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
              if (pokemon.typeRelations.value != null) ...[
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
    final relations = pokemon.typeRelations.value!;
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
        if (relations.halfDamageTo.isNotEmpty) ...[
          const Text('Half Damage To:'),
          Wrap(
            spacing: 8,
            children: relations.halfDamageTo
                .map((type) => Chip(
                      label: Text(type.capitalizeFirst!),
                      backgroundColor: _getTypeColor(type),
                    ))
                .toList(),
          ),
        ],
        if (relations.halfDamageFrom.isNotEmpty) ...[
          const Text('Half Damage From:'),
          Wrap(
            spacing: 8,
            children: relations.halfDamageFrom
                .map((type) => Chip(
                      label: Text(type.capitalizeFirst!),
                      backgroundColor: _getTypeColor(type),
                    ))
                .toList(),
          ),
        ],
        if (relations.noDamageTo.isNotEmpty) ...[
          const Text('No Damage To:'),
          Wrap(
            spacing: 8,
            children: relations.noDamageTo
                .map((type) => Chip(
                      label: Text(type.capitalizeFirst!),
                      backgroundColor: _getTypeColor(type),
                    ))
                .toList(),
          ),
        ],
        if (relations.noDamageFrom.isNotEmpty) ...[
          const Text('No Damage From:'),
          Wrap(
            spacing: 8,
            children: relations.noDamageFrom
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
        return Colors.orange;
      case 'poison':
        return Colors.purple;
      case 'ground':
        return Colors.brown;
      case 'flying':
        return Colors.lightBlueAccent;
      case 'psychic':
        return Colors.pink;
      case 'bug':
        return Colors.lightGreen;
      case 'rock':
        return Colors.brown.shade300;
      case 'ghost':
        return Colors.purple.shade300;
      case 'dragon':
        return Colors.indigo;
      case 'dark':
        return Colors.black54;
      case 'steel':
        return Colors.grey.shade400;
      case 'fairy':
        return Colors.pink.shade200;
      default:
        return Colors.grey;
    }
  }
}

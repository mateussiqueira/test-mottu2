import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/domain/entities/pokemon.dart';
import '../../../pokemon_list/presentation/controllers/related_pokemons_controller.dart';

class PokemonDetailPage extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonDetailPage({super.key, required this.pokemon});

  void _onTypePressed(String type) {
    final controller = Get.put(RelatedPokemonsController(Get.find()));
    controller.loadPokemonsByType(type);
    Get.toNamed('/related-pokemons');
  }

  void _onAbilityPressed(String ability) {
    final controller = Get.put(RelatedPokemonsController(Get.find()));
    controller.loadPokemonsByAbility(ability);
    Get.toNamed('/related-pokemons');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pokemon.name),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'pokemon-${pokemon.id}',
              child: Image.network(
                pokemon.imageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '#${pokemon.id.toString().padLeft(3, '0')}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    pokemon.name,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 16),
                  if (pokemon.types.isNotEmpty) ...[
                    Text(
                      'Types',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: pokemon.types.map((type) {
                        return ActionChip(
                          label: Text(type),
                          onPressed: () => _onTypePressed(type),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),
                  ],
                  if (pokemon.abilities.isNotEmpty) ...[
                    Text(
                      'Abilities',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: pokemon.abilities.map((ability) {
                        return ActionChip(
                          label: Text(ability),
                          onPressed: () => _onAbilityPressed(ability),
                        );
                      }).toList(),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

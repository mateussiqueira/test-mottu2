import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/features/pokemon/domain/entities/pokemon_entity.dart';
import 'package:mobile/features/pokemon_detail/presentation/controllers/pokemon_detail_controller.dart';
import 'package:mobile/features/pokemon_detail/presentation/widgets/pokemon_ability_chip.dart';
import 'package:mobile/features/pokemon_detail/presentation/widgets/pokemon_locations.dart';
import 'package:mobile/features/pokemon_detail/presentation/widgets/related_pokemons.dart';
import 'package:mobile/features/pokemon_list/presentation/pages/pokemon_list_page.dart';

class PokemonDetailPage extends GetView<PokemonDetailController> {
  const PokemonDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(controller.pokemon.value?.name ?? '')),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        final pokemon = controller.pokemon.value;
        if (pokemon == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Image.network(
                  pokemon.imageUrl,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Icon(Icons.error_outline),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pokemon.name,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Height: ${pokemon.height}m',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      'Weight: ${pokemon.weight}kg',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      'Base Experience: ${pokemon.baseExperience}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Types:',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: pokemon.types
                          .map((type) => PokemonAbilityChip(ability: type))
                          .toList(),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Abilities:',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: pokemon.abilities
                          .map(
                              (ability) => PokemonAbilityChip(ability: ability))
                          .toList(),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Locations:',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    PokemonLocations(locations: pokemon.locations),
                    const SizedBox(height: 16),
                    RelatedPokemons(
                      title: 'Pokemons with same type',
                      pokemons: controller.sameTypePokemons,
                      onPokemonTap: (pokemon) {
                        controller.loadPokemon(pokemon.id);
                        Get.to(() => const PokemonDetailPage());
                      },
                    ),
                    const SizedBox(height: 16),
                    RelatedPokemons(
                      title: 'Pokemons with same ability',
                      pokemons: controller.sameAbilityPokemons,
                      onPokemonTap: (pokemon) {
                        controller.loadPokemon(pokemon.id);
                        Get.to(() => const PokemonDetailPage());
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

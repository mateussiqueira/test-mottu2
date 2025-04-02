import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/presentation/routes/app_router.dart';
import '../../../pokemon/domain/entities/pokemon_entity.dart';
import '../controllers/pokemon_detail_controller.dart';

class PokemonDetailPage extends StatelessWidget {
  final PokemonEntityImpl pokemon;
  final bool fromSearch;

  const PokemonDetailPage({
    super.key,
    required this.pokemon,
    this.fromSearch = false,
  });

  Color _getTypeColor(String type) {
    return AppConstants.typeColors[type.toLowerCase()] ?? Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PokemonDetailController>();
    final mainType = pokemon.types.first;
    final mainColor = _getTypeColor(mainType);

    return Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(
        backgroundColor: mainColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            if (fromSearch) {
              Get.offAndToNamed(AppRouter.pokemonList);
            } else {
              Get.back();
            }
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home, color: Colors.white),
            onPressed: () => Get.offAllNamed(AppRouter.pokemonList),
          ),
        ],
        title: Text(
          pokemon.name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        children: [
          // Background design elements
          Positioned(
            right: -50,
            top: -50,
            child: Transform.rotate(
              angle: 0.4,
              child: Icon(
                Icons.catching_pokemon,
                size: 200,
                color: Colors.white.withOpacity(0.2),
              ),
            ),
          ),

          // Main content
          SafeArea(
            child: Column(
              children: [
                // Pokemon image
                Hero(
                  tag: 'pokemon-${pokemon.id}',
                  child: Image.network(
                    pokemon.imageUrl,
                    height: 200,
                    width: 200,
                    fit: BoxFit.contain,
                  ),
                ),

                // Pokemon name and types
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pokemon.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: pokemon.types.map((type) {
                          return GestureDetector(
                            onTap: () async {
                              final pokemons =
                                  await Get.find<PokemonDetailController>()
                                      .fetchPokemonsByType(type);
                              Get.toNamed(
                                '/related-pokemons',
                                arguments: {
                                  'title': 'Pokémons of type $type',
                                  'pokemons': pokemons,
                                },
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text(
                                type,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // Pokemon stats and abilities
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Height and weight
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildInfoCard(
                                context,
                                'Height',
                                '${pokemon.height}m',
                                Icons.height,
                              ),
                              _buildInfoCard(
                                context,
                                'Weight',
                                '${pokemon.weight}kg',
                                Icons.monitor_weight,
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          // Abilities
                          const Text(
                            'Abilities',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            children: pokemon.abilities.map((ability) {
                              return GestureDetector(
                                onTap: () async {
                                  final pokemons =
                                      await Get.find<PokemonDetailController>()
                                          .fetchPokemonsByAbility(ability);
                                  Get.toNamed(
                                    '/related-pokemons',
                                    arguments: {
                                      'title': 'Pokémons with ability $ability',
                                      'pokemons': pokemons,
                                    },
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _getTypeColor(pokemon.types.first)
                                        .withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Text(
                                    ability,
                                    style: TextStyle(
                                      color: _getTypeColor(pokemon.types.first),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(
      BuildContext context, String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: _getTypeColor(pokemon.types.first),
          size: 40,
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

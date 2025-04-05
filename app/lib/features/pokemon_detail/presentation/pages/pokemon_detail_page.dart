import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../pokemon/domain/entities/pokemon_entity.dart';
import '../controllers/i_pokemon_detail_controller.dart';
import '../widgets/pokemon_detail_header.dart';
import '../widgets/pokemon_info_card.dart';
import '../widgets/pokemon_stats_section.dart';
import '../widgets/pokemon_type_ability_section.dart';

/// Page that displays detailed information about a Pokemon
class PokemonDetailPage extends StatelessWidget {
  final PokemonEntity pokemon;
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
    final controller = Get.find<IPokemonDetailController>();
    final mainType = pokemon.types.isEmpty ? 'normal' : pokemon.types.first;
    final mainColor = _getTypeColor(mainType);

    return Scaffold(
      backgroundColor: mainColor,
      appBar: PokemonDetailHeader(
        pokemon: pokemon,
        backgroundColor: mainColor,
        fromSearch: fromSearch,
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
            child: SingleChildScrollView(
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
                        PokemonTypeAbilitySection(
                          pokemon: pokemon,
                          controller: controller,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Pokemon stats and abilities
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Height and weight
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              PokemonInfoCard(
                                title: 'Height',
                                value: '${pokemon.height / 10}m',
                                icon: Icons.height,
                              ),
                              PokemonInfoCard(
                                title: 'Weight',
                                value: '${pokemon.weight / 10}kg',
                                icon: Icons.monitor_weight,
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          // Stats
                          PokemonStatsSection(
                            pokemon: pokemon,
                            mainColor: mainColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

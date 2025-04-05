import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokemon_list/features/pokemon/domain/presentation/controllers/pokemon_detail_controller.dart';
import 'package:pokemon_list/features/pokemon/domain/presentation/widgets/pokemon_detail_error.dart';
import 'package:pokemon_list/features/pokemon/domain/presentation/widgets/pokemon_detail_header.dart';
import 'package:pokemon_list/features/pokemon/domain/presentation/widgets/pokemon_detail_info.dart';
import 'package:pokemon_list/features/pokemon/domain/presentation/widgets/pokemon_detail_loading.dart';
import 'package:pokemon_list/features/pokemon/domain/presentation/widgets/pokemon_detail_stats.dart';
import 'package:pokemon_list/features/pokemon/domain/presentation/widgets/pokemon_type_ability_section.dart';
import 'package:pokemon_list/features/pokemon/domain/presentation/widgets/related_pokemons.dart';

/// Page that displays detailed information about a Pokemon
class PokemonDetailPage extends GetView<PokemonDetailController> {
  const PokemonDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading && controller.pokemon == null) {
          return const PokemonDetailLoading();
        }

        if (controller.error != null) {
          return PokemonDetailError(
            error: controller.error!,
            onRetry: () {
              controller.clearError();
              if (controller.pokemon != null) {
                controller.loadPokemon(controller.pokemon!.id);
              }
            },
          );
        }

        final pokemon = controller.pokemon;
        if (pokemon == null) {
          return const Center(
            child: Text('Pokemon not found'),
          );
        }

        return CustomScrollView(
          slivers: [
            PokemonDetailHeader(pokemon: pokemon),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PokemonDetailInfo(pokemon: pokemon),
                    const SizedBox(height: 16),
                    PokemonTypeAbilitySection(pokemon: pokemon),
                    const SizedBox(height: 16),
                    PokemonDetailStats(pokemon: pokemon),
                    const SizedBox(height: 16),
                    RelatedPokemons(
                      pokemons: controller.relatedPokemons,
                      onPokemonTap: (pokemon) {
                        controller.loadPokemon(pokemon.id);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

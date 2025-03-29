import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/domain/entities/pokemon.dart';
import '../widgets/pokemon_abilities.dart';
import '../widgets/pokemon_image.dart';
import '../widgets/pokemon_info.dart';
import '../widgets/pokemon_stats.dart';
import '../widgets/pokemon_types.dart';

class PokemonDetailPage extends StatelessWidget {
  const PokemonDetailPage({super.key});

  String _getImageUrl(Pokemon pokemon) =>
      pokemon.sprites.other.officialArtwork.frontDefault ?? '';

  List<String> _getTypes(Pokemon pokemon) => pokemon.types
      .map((type) => type.type.name)
      .where((type) => type.isNotEmpty)
      .toList();

  List<String> _getAbilities(Pokemon pokemon) => pokemon.abilities
      .map((ability) => ability.ability.name)
      .where((ability) => ability.isNotEmpty)
      .toList();

  Map<String, int> _getStats(Pokemon pokemon) => Map.fromEntries(
        pokemon.stats.map(
          (stat) => MapEntry(
            stat.stat.name,
            stat.baseStat,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final pokemon = Get.arguments as Pokemon;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          pokemon.name,
          style: const TextStyle(
            fontSize: AppConstants.titleLargeSize,
            fontWeight: FontWeight.w700,
          ),
        ),
        elevation: AppConstants.appBarElevation,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PokemonImage(imageUrl: _getImageUrl(pokemon)),
            Padding(
              padding: const EdgeInsets.all(AppConstants.spacingLarge),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PokemonInfo(
                    name: pokemon.name,
                    height: pokemon.height / 10.0,
                    weight: pokemon.weight / 10.0,
                  ),
                  const SizedBox(height: AppConstants.spacingLarge),
                  PokemonTypes(types: _getTypes(pokemon)),
                  const SizedBox(height: AppConstants.spacingLarge),
                  PokemonAbilities(abilities: _getAbilities(pokemon)),
                  const SizedBox(height: AppConstants.spacingLarge),
                  PokemonStats(stats: _getStats(pokemon)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

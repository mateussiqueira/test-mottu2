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
            PokemonImage(imageUrl: pokemon.imageUrl),
            Padding(
              padding: const EdgeInsets.all(AppConstants.spacingLarge),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PokemonInfo(
                    name: pokemon.name,
                    height: pokemon.height,
                    weight: pokemon.weight,
                  ),
                  const SizedBox(height: AppConstants.spacingLarge),
                  PokemonTypes(types: pokemon.types),
                  const SizedBox(height: AppConstants.spacingLarge),
                  PokemonAbilities(abilities: pokemon.abilities),
                  const SizedBox(height: AppConstants.spacingLarge),
                  PokemonStats(stats: pokemon.stats),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

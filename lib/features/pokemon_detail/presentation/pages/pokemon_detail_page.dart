import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/domain/entities/pokemon.dart';

class PokemonDetailPage extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonDetailPage({
    super.key,
    required this.pokemon,
  });

  String get _imageUrl => pokemon.sprites.other.officialArtwork.frontDefault;

  List<String> get _types => pokemon.types
      .map((type) => type.type.name)
      .where((type) => type.isNotEmpty)
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.spacingMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBasicInfo(),
                  const SizedBox(height: AppConstants.spacingLarge),
                  _buildStats(),
                  const SizedBox(height: AppConstants.spacingLarge),
                  _buildTypes(),
                  const SizedBox(height: AppConstants.spacingLarge),
                  _buildAbilities(),
                  const SizedBox(height: AppConstants.spacingLarge),
                  _buildMoves(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          pokemon.name.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppConstants.typeColors[_types.first.toLowerCase()] ??
                    Colors.grey,
                Colors.white,
              ],
            ),
          ),
          child: Center(
            child: Image.network(
              _imageUrl,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.error_outline,
                  size: AppConstants.iconSizeLarge,
                  color: Colors.red,
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBasicInfo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.spacingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Basic Information',
              style: Theme.of(Get.context!).textTheme.titleLarge,
            ),
            const SizedBox(height: AppConstants.spacingMedium),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildInfoItem('Height', '${pokemon.height / 10}m'),
                _buildInfoItem('Weight', '${pokemon.weight / 10}kg'),
                _buildInfoItem('Base XP', '${pokemon.baseExperience}'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: AppConstants.bodySmallSize,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: AppConstants.spacingSmall),
        Text(
          value,
          style: const TextStyle(
            fontSize: AppConstants.bodyMediumSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildStats() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.spacingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Stats',
              style: Theme.of(Get.context!).textTheme.titleLarge,
            ),
            const SizedBox(height: AppConstants.spacingMedium),
            ...pokemon.stats.map((stat) => Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          stat.stat.name.toUpperCase(),
                          style: const TextStyle(
                            fontSize: AppConstants.bodyMediumSize,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '${stat.baseStat}',
                          style: const TextStyle(
                            fontSize: AppConstants.bodyMediumSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppConstants.spacingSmall),
                    LinearProgressIndicator(
                      value: stat.baseStat / 255,
                      backgroundColor: Colors.grey[200],
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppConstants.typeColors[_types.first.toLowerCase()] ??
                            Colors.grey,
                      ),
                    ),
                    const SizedBox(height: AppConstants.spacingMedium),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildTypes() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.spacingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Types',
              style: Theme.of(Get.context!).textTheme.titleLarge,
            ),
            const SizedBox(height: AppConstants.spacingMedium),
            Wrap(
              spacing: AppConstants.spacingSmall,
              runSpacing: AppConstants.spacingSmall,
              children: _types.map((type) {
                return Container(
                  padding: AppConstants.chipPadding,
                  decoration: BoxDecoration(
                    color: AppConstants.typeColors[type.toLowerCase()] ??
                        Colors.grey,
                    borderRadius:
                        BorderRadius.circular(AppConstants.chipBorderRadius),
                  ),
                  child: Text(
                    type,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: AppConstants.chipFontSize,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAbilities() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.spacingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Abilities',
              style: Theme.of(Get.context!).textTheme.titleLarge,
            ),
            const SizedBox(height: AppConstants.spacingMedium),
            ...pokemon.abilities.map((ability) => Padding(
                  padding: const EdgeInsets.only(
                    bottom: AppConstants.spacingSmall,
                  ),
                  child: Row(
                    children: [
                      Text(
                        ability.ability.name.toUpperCase(),
                        style: const TextStyle(
                          fontSize: AppConstants.bodyMediumSize,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (ability.isHidden) ...[
                        const SizedBox(width: AppConstants.spacingSmall),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppConstants.spacingSmall,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'Hidden',
                            style: TextStyle(
                              fontSize: AppConstants.bodySmallSize,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildMoves() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.spacingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Moves',
              style: Theme.of(Get.context!).textTheme.titleLarge,
            ),
            const SizedBox(height: AppConstants.spacingMedium),
            Wrap(
              spacing: AppConstants.spacingSmall,
              runSpacing: AppConstants.spacingSmall,
              children: pokemon.moves
                  .take(10)
                  .map((move) => Container(
                        padding: AppConstants.chipPadding,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(
                              AppConstants.chipBorderRadius),
                        ),
                        child: Text(
                          move.move.name.toUpperCase(),
                          style: const TextStyle(
                            fontSize: AppConstants.chipFontSize,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/domain/entities/pokemon.dart';

class PokemonGridItem extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonGridItem({
    super.key,
    required this.pokemon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: AppConstants.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
      ),
      child: InkWell(
        onTap: () => Get.toNamed(
          AppConstants.detailRoute,
          arguments: pokemon,
        ),
        child: Padding(
          padding: AppConstants.cardPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Image.network(
                  pokemon.imageUrl,
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
              const SizedBox(height: AppConstants.spacingMedium),
              Text(
                pokemon.name,
                style: const TextStyle(
                  fontSize: AppConstants.bodyMediumSize,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: AppConstants.spacingSmall),
              Wrap(
                spacing: AppConstants.spacingSmall,
                runSpacing: AppConstants.spacingSmall,
                alignment: WrapAlignment.center,
                children: pokemon.types.map((type) {
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
      ),
    );
  }
}

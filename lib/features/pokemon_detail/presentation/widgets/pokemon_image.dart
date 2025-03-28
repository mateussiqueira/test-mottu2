import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';

class PokemonImage extends StatelessWidget {
  final String imageUrl;

  const PokemonImage({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        padding: const EdgeInsets.all(AppConstants.spacingLarge),
        child: Image.network(
          imageUrl,
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
    );
  }
}

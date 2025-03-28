import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';

class PokemonTypes extends StatelessWidget {
  final List<String> types;

  const PokemonTypes({
    super.key,
    required this.types,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          AppConstants.statsLabel,
          style: TextStyle(
            fontSize: AppConstants.titleMediumSize,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppConstants.spacingMedium),
        Wrap(
          spacing: AppConstants.spacingSmall,
          runSpacing: AppConstants.spacingSmall,
          children: types.map((type) {
            return Container(
              padding: AppConstants.chipPadding,
              decoration: BoxDecoration(
                color:
                    AppConstants.typeColors[type.toLowerCase()] ?? Colors.grey,
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
    );
  }
}

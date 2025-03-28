import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';

class PokemonAbilities extends StatelessWidget {
  final List<String> abilities;

  const PokemonAbilities({
    super.key,
    required this.abilities,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          AppConstants.abilitiesLabel,
          style: TextStyle(
            fontSize: AppConstants.titleMediumSize,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppConstants.spacingMedium),
        Wrap(
          spacing: AppConstants.spacingSmall,
          runSpacing: AppConstants.spacingSmall,
          children: abilities.map((ability) {
            return Container(
              padding: AppConstants.chipPadding,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius:
                    BorderRadius.circular(AppConstants.chipBorderRadius),
              ),
              child: Text(
                ability,
                style: const TextStyle(
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

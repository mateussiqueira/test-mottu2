import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';

class PokemonInfo extends StatelessWidget {
  final String name;
  final double height;
  final double weight;

  const PokemonInfo({
    super.key,
    required this.name,
    required this.height,
    required this.weight,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: const TextStyle(
            fontSize: AppConstants.titleLargeSize,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: AppConstants.spacingMedium),
        Row(
          children: [
            _buildInfoItem(
              'Height',
              '${height.toStringAsFixed(1)} ${AppConstants.metersUnit}',
            ),
            const SizedBox(width: AppConstants.spacingLarge),
            _buildInfoItem(
              'Weight',
              '${weight.toStringAsFixed(1)} ${AppConstants.kilogramsUnit}',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: AppConstants.bodyMediumSize,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: AppConstants.spacingSmall),
        Text(
          value,
          style: const TextStyle(
            fontSize: AppConstants.bodyLargeSize,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

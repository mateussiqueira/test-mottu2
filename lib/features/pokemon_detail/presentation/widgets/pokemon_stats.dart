import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';

class PokemonStats extends StatelessWidget {
  final Map<String, int> stats;

  const PokemonStats({
    super.key,
    required this.stats,
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
        ...stats.entries.map((entry) {
          return Padding(
            padding: const EdgeInsets.only(bottom: AppConstants.spacingMedium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      entry.key,
                      style: const TextStyle(
                        fontSize: AppConstants.bodyMediumSize,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      entry.value.toString(),
                      style: const TextStyle(
                        fontSize: AppConstants.bodyMediumSize,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppConstants.spacingSmall),
                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(AppConstants.statsBarRadius),
                  child: LinearProgressIndicator(
                    value: entry.value / AppConstants.maxStatValue,
                    minHeight: AppConstants.statsBarHeight,
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      _getStatColor(entry.key),
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  Color _getStatColor(String stat) {
    switch (stat.toLowerCase()) {
      case 'hp':
        return Colors.red;
      case 'attack':
        return Colors.orange;
      case 'defense':
        return Colors.yellow[700]!;
      case 'special-attack':
        return Colors.purple;
      case 'special-defense':
        return Colors.blue;
      case 'speed':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}

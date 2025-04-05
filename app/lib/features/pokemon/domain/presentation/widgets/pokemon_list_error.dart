import 'package:flutter/material.dart';
import 'package:pokemon_list/features/pokemon/domain/failures/pokemon_failure.dart';

/// Widget that displays an error state for Pokemon list
class PokemonListError extends StatelessWidget {
  final PokemonFailure error;
  final VoidCallback onRetry;

  const PokemonListError({
    super.key,
    required this.error,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(height: 16),
          Text(
            _getErrorMessage(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onRetry,
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }

  String _getErrorMessage() {
    return error.when(
      api: (message) => 'Failed to load Pokémon: $message',
      network: () =>
          'No internet connection. Please check your connection and try again.',
      notFound: () => 'Pokémon not found.',
      unknown: () => 'An unexpected error occurred. Please try again.',
    );
  }
}

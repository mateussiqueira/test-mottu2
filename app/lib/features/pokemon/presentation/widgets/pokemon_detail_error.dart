import 'package:flutter/material.dart';

import '../../../../core/presentation/l10n/app_localizations.dart';

/// Widget de erro para os detalhes do Pokemon
class PokemonDetailError extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const PokemonDetailError({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 48.0,
              color: Colors.red,
            ),
            const SizedBox(height: 16.0),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text(AppLocalizations.tryAgain),
            ),
          ],
        ),
      ),
    );
  }
}

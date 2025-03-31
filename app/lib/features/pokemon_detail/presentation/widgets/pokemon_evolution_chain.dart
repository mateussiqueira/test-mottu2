import 'package:flutter/material.dart';

class PokemonEvolutionChain extends StatelessWidget {
  final List<String> evolutionChain;

  const PokemonEvolutionChain({
    super.key,
    required this.evolutionChain,
  });

  @override
  Widget build(BuildContext context) {
    if (evolutionChain.isEmpty) {
      return const Center(
        child: Text('No evolution chain available'),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Evolution Chain',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        if (evolutionChain.length == 1)
          Text(
            evolutionChain.first,
            style: const TextStyle(fontSize: 16),
          )
        else
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < evolutionChain.length; i++) ...[
                Text(
                  evolutionChain[i],
                  style: const TextStyle(fontSize: 16),
                ),
                if (i < evolutionChain.length - 1)
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Icon(Icons.arrow_forward),
                  ),
              ],
            ],
          ),
      ],
    );
  }
}

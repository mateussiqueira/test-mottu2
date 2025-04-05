
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/domain/entities/pokemon.dart';

class PokemonImage extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonImage({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: double.infinity,
        height: 200,
        padding: const EdgeInsets.all(16),
        child: CachedNetworkImage(
          imageUrl: pokemon.imageUrl,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

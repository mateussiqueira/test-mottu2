import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/presentation/routes/app_router.dart';
import '../../../pokemon/domain/entities/pokemon_entity.dart';
import '../widgets/pokemon_detail_header.dart';
import '../widgets/pokemon_detail_info.dart';
import '../widgets/pokemon_detail_stats.dart';

class PokemonDetailPage extends StatelessWidget {
  final PokemonEntityImpl pokemon;

  const PokemonDetailPage({
    super.key,
    required this.pokemon,
  });

  String get _imageUrl => pokemon.imageUrl;

  List<String> get _types => pokemon.types;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pokemon.name.toUpperCase()),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.offAllNamed(AppRouter.pokemonList),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            PokemonDetailHeader(
              imageUrl: _imageUrl,
              types: _types,
            ),
            PokemonDetailInfo(
              height: pokemon.height.toInt(),
              weight: pokemon.weight.toInt(),
              baseExperience: pokemon.baseExperience.toInt(),
              abilities: pokemon.abilities,
              moves: const [],
            ),
            const PokemonDetailStats(
              stats: [],
              statNames: [],
            ),
          ],
        ),
      ),
    );
  }
}

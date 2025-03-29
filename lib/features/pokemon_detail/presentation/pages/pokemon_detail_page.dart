import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/presentation/routes/app_router.dart';
import '../../../../features/pokemon_list/domain/entities/pokemon.dart';
import '../widgets/pokemon_detail_header.dart';
import '../widgets/pokemon_detail_info.dart';
import '../widgets/pokemon_detail_stats.dart';

class PokemonDetailPage extends StatelessWidget {
  final PokemonEntity pokemon;

  const PokemonDetailPage({
    super.key,
    required this.pokemon,
  });

  String get _imageUrl {
    return pokemon.sprites.other?.officialArtwork?.frontDefault ??
        pokemon.sprites.frontDefault ??
        '';
  }

  List<String> get _types {
    return pokemon.types.map((type) => type.name).toList();
  }

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
              height: pokemon.height,
              weight: pokemon.weight,
              baseExperience: pokemon.baseExperience ?? 0,
              abilities:
                  pokemon.abilities.map((ability) => ability.name).toList(),
              moves: pokemon.moves.map((move) => move.name).toList(),
            ),
            PokemonDetailStats(
              stats: pokemon.stats.map((stat) => stat.baseStat).toList(),
              statNames: pokemon.stats.map((stat) => stat.name).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

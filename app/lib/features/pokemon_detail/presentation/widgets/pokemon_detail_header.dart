import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/route_names.dart';
import '../../../pokemon/domain/entities/pokemon_entity.dart';

class PokemonDetailHeader extends StatelessWidget
    implements PreferredSizeWidget {
  final PokemonEntity pokemon;
  final Color backgroundColor;
  final bool fromSearch;

  const PokemonDetailHeader({
    super.key,
    required this.pokemon,
    required this.backgroundColor,
    this.fromSearch = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {
          if (fromSearch) {
            Get.offAndToNamed(RouteNames.pokemonList);
          } else {
            Get.back();
          }
        },
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.home, color: Colors.white),
          onPressed: () => Get.offAllNamed(RouteNames.pokemonList),
        ),
      ],
      title: Text(
        pokemon.name,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

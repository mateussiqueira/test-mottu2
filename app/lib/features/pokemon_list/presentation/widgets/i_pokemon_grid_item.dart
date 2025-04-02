import 'package:flutter/material.dart';

import '../../../../features/pokemon/domain/entities/pokemon_entity.dart';

abstract class IPokemonGridItem extends StatelessWidget {
  final PokemonEntity pokemon;

  const IPokemonGridItem({
    super.key,
    required this.pokemon,
  });

  @override
  Widget build(BuildContext context);
}

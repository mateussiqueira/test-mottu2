import 'package:flutter/material.dart';

import '../../../../features/pokemon/domain/entities/pokemon_entity.dart';

/// Interface for Pokemon search delegate
abstract class IPokemonSearchDelegate {
  List<Widget> buildActions(BuildContext context);
  Widget buildLeading(BuildContext context);
  Widget buildResults(BuildContext context);
  Widget buildSuggestions(BuildContext context);
  void navigateToDetail(PokemonEntity pokemon);
}

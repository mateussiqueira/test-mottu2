import 'package:flutter/material.dart';

import '../../../../features/pokemon/domain/entities/i_pokemon_entity.dart';
import '../controllers/i_pokemon_search_controller.dart';

/// Interface for Pokemon search delegate
abstract class IPokemonSearchDelegate extends SearchDelegate<IPokemonEntity?> {
  final IPokemonSearchController controller;

  IPokemonSearchDelegate(this.controller);

  @override
  List<Widget> buildActions(BuildContext context);

  @override
  Widget buildLeading(BuildContext context);

  @override
  Widget buildResults(BuildContext context);

  @override
  Widget buildSuggestions(BuildContext context);
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'pokemon_search_results.dart';

/// Search delegate for Pokemon list
class PokemonSearchDelegate extends SearchDelegate<String> {
  final WidgetRef ref;

  PokemonSearchDelegate(this.ref);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return PokemonSearchResults(query: query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return PokemonSearchResults(query: query);
  }
}

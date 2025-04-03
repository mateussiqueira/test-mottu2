import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../features/pokemon/domain/entities/pokemon_entity.dart';
import '../controllers/i_pokemon_search_controller.dart';
import '../widgets/pokemon_card.dart';
import 'i_pokemon_search_delegate.dart';

/// Implementation of Pokemon search delegate
class PokemonSearchDelegate extends SearchDelegate<PokemonEntity?>
    implements IPokemonSearchDelegate {
  final IPokemonSearchController controller;

  PokemonSearchDelegate(this.controller);

  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'normal':
        return const Color(0xFFA8A878);
      case 'fire':
        return const Color(0xFFF08030);
      case 'water':
        return const Color(0xFF6890F0);
      case 'electric':
        return const Color(0xFFF8D030);
      case 'grass':
        return const Color(0xFF78C850);
      case 'ice':
        return const Color(0xFF98D8D8);
      case 'fighting':
        return const Color(0xFFC03028);
      case 'poison':
        return const Color(0xFFA040A0);
      case 'ground':
        return const Color(0xFFE0C068);
      case 'flying':
        return const Color(0xFFA890F0);
      case 'psychic':
        return const Color(0xFFF85888);
      case 'bug':
        return const Color(0xFFA8B820);
      case 'rock':
        return const Color(0xFFB8A038);
      case 'ghost':
        return const Color(0xFF705898);
      case 'dragon':
        return const Color(0xFF7038F8);
      case 'dark':
        return const Color(0xFF705848);
      case 'steel':
        return const Color(0xFFB8B8D0);
      case 'fairy':
        return const Color(0xFFEE99AC);
      default:
        return const Color(0xFFA8A878);
    }
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          controller.clearSearch();
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    controller.search(query);
    return _buildSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return const Center(
        child: Text('Start typing to search Pokemon'),
      );
    }

    controller.search(query);
    return _buildSearchResults();
  }

  Widget _buildSearchResults() {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      final error = controller.error;
      if (error != null && error.isNotEmpty) {
        return Center(
          child: Text(
            error,
            style: const TextStyle(color: Colors.red),
          ),
        );
      }

      if (controller.searchResults.isEmpty) {
        return const Center(
          child: Text('No Pokemon found'),
        );
      }

      return ListView.builder(
        itemCount: controller.searchResults.length,
        itemBuilder: (context, index) {
          final pokemon = controller.searchResults[index];
          return PokemonCard(
            pokemon: pokemon,
            onTap: () {
              controller.navigateToDetail(pokemon);
              close(context, pokemon);
            },
          );
        },
      );
    });
  }

  @override
  void navigateToDetail(PokemonEntity pokemon) {
    controller.navigateToDetail(pokemon);
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../features/pokemon/presentation/routes/pokemon_router.dart';
import '../controllers/pokemon_list_controller.dart';
import '../widgets/pokemon_grid.dart';

/// Page for displaying the list of Pokemon
class PokemonListPage extends GetView<PokemonListController> {
  const PokemonListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokemon List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => Get.toNamed(PokemonRouter.pokemonSearch),
          ),
        ],
      ),
      body: Obx(
        () => controller.state.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : controller.hasError
                ? Center(child: Text(controller.error ?? 'Unknown error'))
                : PokemonGrid(
                    pokemons: controller.state.pokemons,
                    hasMore: controller.state.hasMore.value,
                    onLoadMore: controller.loadMore,
                    fromSearch: false,
                  ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/i_pokemon_list_controller.dart';
import '../widgets/pokemon_grid.dart';

class PokemonSearchPage extends StatelessWidget {
  const PokemonSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<IPokemonListController>();
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Search Pokemon',
            border: InputBorder.none,
          ),
          onChanged: (value) => controller.search(value),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            controller.clearSearch();
            Get.back();
          },
        ),
      ),
      body: Obx(
        () => controller.state.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : controller.hasError
                ? Center(child: Text(controller.error ?? 'Unknown error'))
                : PokemonGrid(
                    pokemons: controller.pokemons,
                    hasMore: controller.state.hasMore.value,
                    onLoadMore: controller.loadMore,
                    isLoading: controller.state.isLoadingMore.value,
                  ),
      ),
    );
  }
}

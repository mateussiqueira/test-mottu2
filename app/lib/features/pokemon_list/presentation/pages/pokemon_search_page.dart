import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/pokemon_list_controller.dart';
import '../widgets/pokemon_grid.dart';

class PokemonSearchPage extends GetView<PokemonListController> {
  const PokemonSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            controller.clearSearch();
            Get.back();
          },
        ),
        title: TextField(
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Search Pokemon',
            border: InputBorder.none,
          ),
          onChanged: controller.search,
        ),
      ),
      body: Obx(
        () => controller.state.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : PokemonGrid(
                pokemons: controller.state.searchResults,
                hasMore: false,
                onLoadMore: () {},
                fromSearch: true,
              ),
      ),
    );
  }
}

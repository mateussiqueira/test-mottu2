import 'package:get/get.dart';

import '../../../../core/logging/i_logger.dart';
import '../../../pokemon/domain/repositories/i_pokemon_repository.dart';
import '../../domain/repositories/i_pokemon_detail_repository.dart';
import 'base_pokemon_detail_controller.dart';
import 'base_pokemon_detail_use_cases.dart';
import 'i_pokemon_detail_binding.dart';

abstract class BasePokemonDetailBinding extends Bindings
    implements IPokemonDetailBinding {
  @override
  final ILogger logger;
  @override
  final IPokemonRepository pokemonRepository;
  @override
  final IPokemonDetailRepository detailRepository;
  late final BasePokemonDetailUseCases useCases;
  late final BasePokemonDetailController controller;

  BasePokemonDetailBinding({
    required this.logger,
    required this.pokemonRepository,
    required this.detailRepository,
  });

  @override
  void dependencies() {
    useCases = createUseCases();
    useCases.registerUseCases();

    controller = createController();
    Get.lazyPut(() => controller.createController());
  }

  BasePokemonDetailUseCases createUseCases();
  BasePokemonDetailController createController();
}

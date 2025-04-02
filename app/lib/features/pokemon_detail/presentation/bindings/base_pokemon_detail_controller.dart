import 'package:get/get.dart';

import '../../../../core/logging/i_logger.dart';
import '../../../../core/performance/i_performance_monitor.dart';
import '../../../pokemon/domain/entities/i_pokemon_entity.dart';
import '../../../pokemon/domain/repositories/i_pokemon_repository.dart';
import '../../domain/usecases/get_pokemon_detail.dart';
import '../../domain/usecases/get_pokemons_by_ability.dart';
import '../../domain/usecases/get_pokemons_by_type.dart';
import '../controllers/pokemon_detail_controller.dart';

/// Base class for Pokemon detail controller bindings
abstract class BasePokemonDetailController {
  final ILogger logger;
  final IPokemonRepository repository;
  final GetPokemonDetail getPokemonDetail;
  final GetPokemonsByType getPokemonsByType;
  final GetPokemonsByAbility getPokemonsByAbility;
  final IPerformanceMonitor performanceMonitor;

  BasePokemonDetailController({
    required this.logger,
    required this.repository,
    required this.getPokemonDetail,
    required this.getPokemonsByType,
    required this.getPokemonsByAbility,
    required this.performanceMonitor,
  });

  PokemonDetailController createController() {
    final controller = PokemonDetailController(
      logger: logger,
      repository: repository,
      performanceMonitor: performanceMonitor,
    );

    final arguments = Get.arguments;
    if (arguments is Map<String, dynamic> &&
        arguments['pokemon'] is IPokemonEntity) {
      controller.setPokemon(arguments['pokemon'] as IPokemonEntity);
    }

    return controller;
  }
}

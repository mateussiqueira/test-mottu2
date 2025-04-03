import 'package:get/get.dart';

import '../../../../core/logging/i_logger.dart';
import '../../../../core/performance/i_performance_monitor.dart';
import '../../../../core/state/base_state_controller.dart';
import '../../../pokemon/domain/entities/pokemon_entity.dart';

/// Interface for the Pokemon detail controller
abstract class IPokemonDetailController extends BaseStateController {
  IPokemonDetailController({
    required ILogger logger,
    required IPerformanceMonitor performanceMonitor,
  }) : super(logger: logger, performanceMonitor: performanceMonitor);

  /// Gets the current Pokemon
  PokemonEntity? get pokemon;

  /// Sets the current Pokemon
  void setPokemon(PokemonEntity pokemon);

  /// Gets the list of Pokemon with the same type
  RxList<PokemonEntity> get sameTypePokemons;

  /// Gets the list of Pokemon with the same ability
  RxList<PokemonEntity> get sameAbilityPokemons;

  /// Fetches Pokemon with the same type
  Future<void> fetchPokemonsByType(String type);

  /// Fetches Pokemon with the same ability
  Future<void> fetchPokemonsByAbility(String ability);

  /// Navigates to the related Pokemon list page
  void navigateToRelatedPokemons(List<PokemonEntity> pokemons, String title);
}

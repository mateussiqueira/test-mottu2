import '../../../../core/logging/i_logger.dart';
import '../../../../core/performance/i_performance_monitor.dart';
import '../../../pokemon/domain/repositories/i_pokemon_repository.dart';
import '../../domain/usecases/get_pokemon_detail.dart';
import '../../domain/usecases/get_pokemons_by_ability.dart';
import '../../domain/usecases/get_pokemons_by_type.dart';
import 'base_pokemon_detail_controller.dart';

/// Base implementation for Pokemon detail controller bindings
class PokemonDetailControllerBase extends BasePokemonDetailController {
  PokemonDetailControllerBase({
    required ILogger logger,
    required IPokemonRepository repository,
    required GetPokemonDetail getPokemonDetail,
    required GetPokemonsByType getPokemonsByType,
    required GetPokemonsByAbility getPokemonsByAbility,
    required IPerformanceMonitor performanceMonitor,
  }) : super(
          logger: logger,
          repository: repository,
          getPokemonDetail: getPokemonDetail,
          getPokemonsByType: getPokemonsByType,
          getPokemonsByAbility: getPokemonsByAbility,
          performanceMonitor: performanceMonitor,
        );
}

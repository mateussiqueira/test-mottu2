import 'package:get/get.dart';

import '../../../../core/constants/route_names.dart';
import '../../../../core/logging/i_logger.dart';
import '../../../../core/performance/i_performance_monitor.dart';
import '../../../../core/state/base_state_controller.dart';
import '../../../pokemon/domain/entities/pokemon_entity.dart';
import '../../../pokemon/domain/entities/pokemon_entity_impl.dart';
import '../../../pokemon/domain/repositories/i_pokemon_repository.dart';
import 'i_pokemon_detail_controller.dart';

/// Controller for Pokemon detail page
class PokemonDetailController extends BaseStateController
    implements IPokemonDetailController {
  final IPokemonRepository repository;
  final _sameTypePokemons = <PokemonEntity>[].obs;
  final _sameAbilityPokemons = <PokemonEntity>[].obs;
  final _pokemon = Rx<PokemonEntity?>(null);

  PokemonDetailController({
    required this.repository,
    required ILogger logger,
    required IPerformanceMonitor performanceMonitor,
  }) : super(logger: logger, performanceMonitor: performanceMonitor);

  @override
  PokemonEntity? get pokemon => _pokemon.value;

  @override
  void setPokemon(PokemonEntity pokemon) {
    _pokemon.value = pokemon;
    // Load related Pokemon
    if (pokemon.types.isNotEmpty) {
      fetchPokemonsByType(pokemon.types.first);
    }
    if (pokemon.abilities.isNotEmpty) {
      fetchPokemonsByAbility(pokemon.abilities.first);
    }
  }

  @override
  RxList<PokemonEntity> get sameTypePokemons => _sameTypePokemons;

  @override
  RxList<PokemonEntity> get sameAbilityPokemons => _sameAbilityPokemons;

  @override
  Future<void> fetchPokemonsByType(String type) async {
    setLoading(true);
    try {
      logger.info('Fetching Pokemon by type', data: {'type': type});
      final result = await repository.getPokemonsByType(type);
      result.fold(
        (failure) {
          setError(failure.message);
          logger.error('Failed to fetch Pokemon by type',
              error: failure, data: {'type': type});
        },
        (pokemons) {
          final List<PokemonEntity> typedPokemons = pokemons.cast<PokemonEntity>();
          _sameTypePokemons.value = typedPokemons;
          logger.info(
            'Successfully fetched Pokemon by type',
            data: {'type': type, 'count': pokemons.length},
          );
        },
      );
    } catch (e, stackTrace) {
      logger.error('Error fetching Pokemon by type',
          error: e, stackTrace: stackTrace);
      setError('Failed to fetch Pokemon by type');
    } finally {
      setLoading(false);
    }
  }

  @override
  Future<void> fetchPokemonsByAbility(String ability) async {
    setLoading(true);
    try {
      logger.info('Fetching Pokemon by ability', data: {'ability': ability});
      final result = await repository.getPokemonsByAbility(ability);
      result.fold(
        (failure) {
          setError(failure.message);
          logger.error('Failed to fetch Pokemon by ability',
              error: failure, data: {'ability': ability});
        },
        (pokemons) {
          final List<PokemonEntity> typedPokemons = pokemons.cast<PokemonEntity>();
          _sameAbilityPokemons.value = typedPokemons;
          logger.info(
            'Successfully fetched Pokemon by ability',
            data: {'ability': ability, 'count': pokemons.length},
          );
        },
      );
    } catch (e, stackTrace) {
      logger.error('Error fetching Pokemon by ability',
          error: e, stackTrace: stackTrace);
      setError('Failed to fetch Pokemon by ability');
    } finally {
      setLoading(false);
    }
  }

  @override
  void navigateToRelatedPokemons(List<PokemonEntity> pokemons, String title) {
    Get.toNamed(
      RouteNames.pokemonType,
      arguments: {
        'pokemons': pokemons,
        'title': title,
      },
    );
  }
}

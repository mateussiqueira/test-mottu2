import 'package:get/get.dart';

import '../../../../core/presentation/adapters/getx_adapter.dart';
import '../../../../core/state/base_state_controller.dart';
import '../../../../features/pokemon/domain/entities/pokemon_entity.dart';
import '../../../../features/pokemon/domain/repositories/pokemon_repository.dart';
import '../../domain/usecases/get_pokemon_detail.dart';
import '../../domain/usecases/get_pokemons_by_ability.dart';
import '../../domain/usecases/get_pokemons_by_type.dart';
import 'i_pokemon_detail_controller.dart';

class PokemonDetailController extends BaseStateController
    implements IPokemonDetailController {
  final GetPokemonDetail getPokemonDetail;
  final GetPokemonsByType getPokemonsByType;
  final GetPokemonsByAbility getPokemonsByAbility;
  final PokemonRepository repository;
  final _adapter = GetXAdapter();

  final _pokemon = Rxn<PokemonEntity>();
  final _sameTypePokemons = <PokemonEntity>[].obs;
  final _sameAbilityPokemons = <PokemonEntity>[].obs;

  PokemonDetailController({
    required this.getPokemonDetail,
    required this.getPokemonsByType,
    required this.getPokemonsByAbility,
    required this.repository,
  });

  @override
  Rxn<PokemonEntity> get pokemon => _pokemon;

  @override
  RxBool get isLoading => isLoading;

  @override
  RxString get error => error;

  @override
  RxList<PokemonEntity> get sameTypePokemons => _sameTypePokemons;

  @override
  RxList<PokemonEntity> get sameAbilityPokemons => _sameAbilityPokemons;

  @override
  Future<void> fetchPokemonById(int id) async {
    await trackOperation('detail_load', () async {
      setLoading(true);
      clearError();

      logger.info('Fetching Pokemon detail', data: {'id': id});
      final result = await getPokemonDetail(id);
      _pokemon.value = result;
      logger.info(
        'Successfully fetched Pokemon detail',
        data: {'id': id},
      );
    });
  }

  @override
  Future<void> fetchPokemonsByType(String type) async {
    await trackOperation('type_related', () async {
      setLoading(true);
      clearError();

      logger.info('Fetching Pokemon by type', data: {'type': type});
      final result = await getPokemonsByType(type);
      _sameTypePokemons.value = result;
      logger.info(
        'Successfully fetched Pokemon by type',
        data: {'type': type, 'count': result.length},
      );
    });
  }

  @override
  Future<void> fetchPokemonsByAbility(String ability) async {
    await trackOperation('ability_related', () async {
      setLoading(true);
      clearError();

      logger.info('Fetching Pokemon by ability', data: {'ability': ability});
      final result = await getPokemonsByAbility(ability);
      _sameAbilityPokemons.value = result;
      logger.info(
        'Successfully fetched Pokemon by ability',
        data: {'ability': ability, 'count': result.length},
      );
    });
  }

  @override
  void navigateToRelatedPokemons(List<PokemonEntity> pokemons, String title) {
    _adapter.toNamed(
      '/related-pokemons',
      arguments: {'pokemons': pokemons, 'title': title},
    );
  }
}

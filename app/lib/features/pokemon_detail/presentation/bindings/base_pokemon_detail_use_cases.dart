import 'package:get/get.dart';

import '../../../../core/logging/i_logger.dart';
import '../../../pokemon/domain/repositories/i_pokemon_repository.dart';
import '../../domain/repositories/i_pokemon_detail_repository.dart';
import '../../domain/usecases/get_pokemon_detail.dart';
import '../../domain/usecases/get_pokemons_by_ability.dart';
import '../../domain/usecases/get_pokemons_by_type.dart';
import 'i_pokemon_detail_use_cases.dart';

abstract class BasePokemonDetailUseCases implements IPokemonDetailUseCases {
  @override
  final ILogger logger;
  @override
  final IPokemonRepository pokemonRepository;
  @override
  final IPokemonDetailRepository detailRepository;

  BasePokemonDetailUseCases({
    required this.logger,
    required this.pokemonRepository,
    required this.detailRepository,
  });

  @override
  void registerUseCases() {
    registerGetPokemonDetail();
    registerGetPokemonsByType();
    registerGetPokemonsByAbility();
  }

  void registerGetPokemonDetail() {
    Get.lazyPut<GetPokemonDetail>(
      () => GetPokemonDetail(pokemonRepository),
    );
  }

  void registerGetPokemonsByType() {
    Get.lazyPut<GetPokemonsByType>(
      () => GetPokemonsByType(
        repository: detailRepository,
      ),
    );
  }

  void registerGetPokemonsByAbility() {
    Get.lazyPut<GetPokemonsByAbility>(
      () => GetPokemonsByAbility(
        repository: detailRepository,
      ),
    );
  }
}

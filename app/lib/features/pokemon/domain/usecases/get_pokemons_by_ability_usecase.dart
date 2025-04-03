import '../../../../core/domain/errors/result.dart';
import '../entities/pokemon_entity.dart';
import '../repositories/i_pokemon_repository.dart';

class GetPokemonsByAbilityUseCase {
  final IPokemonRepository _repository;

  GetPokemonsByAbilityUseCase(this._repository);

  Future<Result<List<PokemonEntity>>> call(String ability) async {
    return await _repository.getPokemonsByAbility(ability);
  }
}

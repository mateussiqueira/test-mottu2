import '../../../../core/domain/errors/failure.dart';
import '../../../../core/domain/errors/result.dart';
import '../entities/pokemon_entity.dart';
import '../repositories/i_pokemon_repository.dart';
import 'i_get_pokemons_by_ability.dart';

class GetPokemonsByAbility implements IGetPokemonsByAbility {
  final IPokemonRepository _repository;

  GetPokemonsByAbility(this._repository);

  @override
  Future<Result<List<PokemonEntity>>> call(String ability) async {
    try {
      final result = await _repository.getPokemonsByAbility(ability);
      return result;
    } catch (e) {
      return Result.failure(Failure(
          message: 'Failed to get Pokemon by ability: ${e.toString()}'));
    }
  }
}

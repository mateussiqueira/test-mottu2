import '../../../../core/domain/errors/failure.dart';
import '../../../../core/domain/errors/result.dart';
import '../entities/pokemon_entity.dart';
import '../repositories/i_pokemon_repository.dart';
import 'i_get_pokemons_by_type.dart';

class GetPokemonsByType implements IGetPokemonsByType {
  final IPokemonRepository _repository;

  GetPokemonsByType(this._repository);

  @override
  Future<Result<List<PokemonEntity>>> call(String type) async {
    try {
      final result = await _repository.getPokemonsByType(type);
      return result;
    } catch (e) {
      return Result.failure(
          Failure(message: 'Failed to get Pokemon by type: ${e.toString()}'));
    }
  }
}

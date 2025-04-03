import '../../../../core/domain/errors/result.dart';
import '../entities/pokemon_entity.dart';
import '../repositories/i_pokemon_repository.dart';

class GetPokemonsByTypeUseCase {
  final IPokemonRepository _repository;

  GetPokemonsByTypeUseCase(this._repository);

  Future<Result<List<PokemonEntity>>> call(String type) async {
    return await _repository.getPokemonsByType(type);
  }
}

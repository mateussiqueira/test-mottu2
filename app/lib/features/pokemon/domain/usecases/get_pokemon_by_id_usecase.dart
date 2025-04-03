import '../../../../core/domain/errors/result.dart';
import '../entities/pokemon_entity.dart';
import '../repositories/i_pokemon_repository.dart';

class GetPokemonByIdUseCase {
  final IPokemonRepository _repository;

  GetPokemonByIdUseCase(this._repository);

  Future<Result<PokemonEntity>> call(int id) async {
    return await _repository.getPokemonById(id);
  }
}

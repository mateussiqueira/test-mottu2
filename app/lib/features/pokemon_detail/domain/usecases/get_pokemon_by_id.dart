import '../../../../core/domain/errors/result.dart';
import '../../../pokemon/domain/entities/i_pokemon_entity.dart';
import '../repositories/pokemon_detail_repository.dart';

class GetPokemonById {
  final PokemonDetailRepository _repository;

  GetPokemonById({
    required PokemonDetailRepository repository,
  }) : _repository = repository;

  Future<Result<IPokemonEntity>> call(int id) async {
    try {
      return await _repository.getPokemonById(id);
    } catch (e) {
      return Result.failure(e);
    }
  }
}

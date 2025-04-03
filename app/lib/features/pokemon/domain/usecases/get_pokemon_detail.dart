import '../../../../core/domain/errors/result.dart';
import '../entities/pokemon_entity.dart';
import '../repositories/i_pokemon_repository.dart';
import 'i_get_pokemon_detail.dart';

class GetPokemonDetail implements IGetPokemonDetail {
  final IPokemonRepository _repository;

  GetPokemonDetail(this._repository);

  @override
  Future<Result<PokemonEntity>> call(int id) async {
    return _repository.getPokemonById(id);
  }
}

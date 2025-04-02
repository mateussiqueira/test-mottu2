import '../../../../core/domain/result.dart' as core;
import '../entities/i_pokemon_entity.dart';
import '../repositories/i_pokemon_repository.dart';
import 'i_get_pokemon_detail.dart';

class GetPokemonDetail implements IGetPokemonDetail {
  final IPokemonRepository _repository;

  GetPokemonDetail(this._repository);

  @override
  Future<core.Result<IPokemonEntity>> call(int id) async {
    return _repository.getPokemonDetail(id);
  }
}

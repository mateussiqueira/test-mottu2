import '../../../../core/domain/result.dart' as core;
import '../entities/i_pokemon_entity.dart';
import '../repositories/i_pokemon_repository.dart';
import 'i_get_pokemons_by_type.dart';

class GetPokemonsByType implements IGetPokemonsByType {
  final IPokemonRepository _repository;

  GetPokemonsByType(this._repository);

  @override
  Future<core.Result<List<IPokemonEntity>>> call(String type) async {
    return _repository.getPokemonsByType(type);
  }
}

import '../../../../core/domain/result.dart' as core;
import '../entities/i_pokemon_entity.dart';
import '../repositories/i_pokemon_repository.dart';
import 'i_get_pokemon_list.dart';

class GetPokemonList implements IGetPokemonList {
  final IPokemonRepository _repository;

  GetPokemonList(this._repository);

  @override
  Future<core.Result<List<IPokemonEntity>>> call({
    required int limit,
    required int offset,
  }) async {
    return _repository.getPokemonList(
      limit: limit,
      offset: offset,
    );
  }
}

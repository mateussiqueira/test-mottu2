import '../../../../core/domain/result.dart' as core;
import '../../../pokemon/domain/entities/pokemon_entity.dart';
import '../repositories/pokemon_repository.dart';

class GetPokemonsUseCase {
  final PokemonRepository repository;

  GetPokemonsUseCase(this.repository);

  Future<core.Result<List<PokemonEntityImpl>>> call(
      {int offset = 0, int limit = 20}) async {
    return repository.getPokemonList(offset: offset, limit: limit);
  }
}

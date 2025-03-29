import 'package:mobile/core/domain/result.dart';
import 'package:mobile/features/pokemon/domain/entities/pokemon_entity.dart';
import 'package:mobile/features/pokemon_list/domain/repositories/pokemon_repository.dart';

/// Caso de uso para buscar a lista de Pokemons
class GetPokemonListUseCase {
  final PokemonRepository _repository;

  GetPokemonListUseCase(this._repository);

  /// Executa o caso de uso
  Future<Result<List<PokemonEntityImpl>>> call({
    required int offset,
    required int limit,
  }) async {
    return _repository.getPokemonList(
      offset: offset,
      limit: limit,
    );
  }
}

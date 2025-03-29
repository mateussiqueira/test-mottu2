import 'package:pokeapi/core/domain/entities/pokemon_entity.dart';
import 'package:pokeapi/core/domain/errors/pokemon_error.dart';
import 'package:pokeapi/features/pokemon/domain/repositories/pokemon_repository.dart';

/// Caso de uso para buscar a lista de Pokemons
class GetPokemonListUseCase {
  final PokemonRepository _repository;

  GetPokemonListUseCase(this._repository);

  /// Executa o caso de uso
  Future<Result<List<PokemonEntity>>> call({
    required int offset,
    required int limit,
  }) async {
    return _repository.getPokemonList(
      offset: offset,
      limit: limit,
    );
  }
}

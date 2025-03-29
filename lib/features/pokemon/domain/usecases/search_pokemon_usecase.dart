import 'package:pokeapi/core/domain/entities/pokemon_entity.dart';
import 'package:pokeapi/core/domain/errors/pokemon_error.dart';
import 'package:pokeapi/features/pokemon/domain/repositories/pokemon_repository.dart';

/// Caso de uso para buscar Pokemons por nome
class SearchPokemonUseCase {
  final PokemonRepository _repository;

  SearchPokemonUseCase(this._repository);

  /// Executa o caso de uso
  Future<Result<List<PokemonEntity>>> call(String query) async {
    return _repository.searchPokemon(query);
  }
}

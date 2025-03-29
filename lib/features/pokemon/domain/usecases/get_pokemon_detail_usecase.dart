import 'package:pokeapi/core/domain/entities/pokemon_entity.dart';
import 'package:pokeapi/core/domain/errors/pokemon_error.dart';
import 'package:pokeapi/features/pokemon/domain/repositories/pokemon_repository.dart';

/// Caso de uso para buscar os detalhes de um Pokemon
class GetPokemonDetailUseCase {
  final PokemonRepository _repository;

  GetPokemonDetailUseCase(this._repository);

  /// Executa o caso de uso
  Future<Result<PokemonEntity>> call(int id) async {
    return _repository.getPokemonDetail(id);
  }
}

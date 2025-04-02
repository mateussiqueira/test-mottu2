import '../../../../core/domain/result.dart' as core;
import '../../../pokemon/domain/entities/i_pokemon_entity.dart';
import '../repositories/pokemon_repository.dart';

/// Use case for searching Pokemon
class SearchPokemonsUseCase {
  final PokemonRepository repository;

  SearchPokemonsUseCase(this.repository);

  /// Searches for Pokemon by name
  Future<core.Result<List<IPokemonEntity>>> call(String query) async {
    return repository.searchPokemon(query);
  }
}

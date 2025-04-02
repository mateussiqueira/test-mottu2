import '../../../../core/domain/result.dart' as core;
import '../../../pokemon/domain/entities/i_pokemon_entity.dart';
import '../repositories/pokemon_repository.dart';

/// Use case for getting a list of Pokemon
class GetPokemonsUseCase {
  final PokemonRepository repository;

  GetPokemonsUseCase(this.repository);

  /// Gets a list of Pokemon with pagination
  Future<core.Result<List<IPokemonEntity>>> call(
      {int offset = 0, int limit = 20}) async {
    return repository.getPokemonList(offset: offset, limit: limit);
  }
}

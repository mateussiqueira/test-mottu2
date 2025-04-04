import '../../../core/result/result.dart';
import '../../entities/pokemon_entity.dart';

/// Interface for searching Pokemon
abstract class ISearchPokemon {
  /// Search Pokemon by query
  Future<Result<List<PokemonEntity>>> call(String query);
}

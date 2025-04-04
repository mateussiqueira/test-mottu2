import '../../../core/result/result.dart';
import '../../entities/pokemon_entity.dart';

/// Interface for getting Pokemon by stat
abstract class IGetPokemonsByStat {
  /// Get Pokemon by stat
  Future<Result<List<PokemonEntity>>> call(String stat, int value);
}

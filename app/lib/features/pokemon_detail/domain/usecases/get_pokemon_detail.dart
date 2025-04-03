import '../../../../core/domain/errors/failure.dart';
import '../../../../core/domain/errors/result.dart';
import '../../../pokemon/domain/entities/pokemon_entity.dart';
import '../../../pokemon/domain/repositories/i_pokemon_repository.dart';
import 'i_get_pokemon_detail.dart';

/// Use case for getting Pokemon details
class GetPokemonDetail implements IGetPokemonDetail {
  final IPokemonRepository repository;

  GetPokemonDetail(this.repository);

  @override
  Future<Result<PokemonEntity>> call(int id) async {
    try {
      final result = await repository.getPokemonDetail(id);
      return result;
    } catch (e) {
      return Result.failure(
          Failure(message: 'Failed to get Pokemon detail: ${e.toString()}'));
    }
  }
}

import '../../../../core/domain/errors/failure.dart';
import '../../../../core/domain/errors/result.dart';
import '../entities/pokemon_entity.dart';
import '../repositories/i_pokemon_repository.dart';
import 'i_get_pokemon_list.dart';

class GetPokemonList implements IGetPokemonList {
  final IPokemonRepository _repository;

  GetPokemonList(this._repository);

  @override
  Future<Result<List<PokemonEntity>>> call({int? limit, int? offset}) async {
    try {
      final result =
          await _repository.getPokemonList(limit: limit, offset: offset);
      if (result.isSuccess) {
        return Result.success(result.data!);
      }
      return result;
    } catch (e) {
      return Result.failure(Failure(message: e.toString()));
    }
  }
}

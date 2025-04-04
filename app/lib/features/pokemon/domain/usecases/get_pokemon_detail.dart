import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../core/result/result.dart';
import '../../entities/pokemon_entity.dart';
import '../../repositories/i_pokemon_repository.dart';
import 'i_get_pokemon_detail.dart';

/// Use case to get Pokemon detail
class GetPokemonDetail implements IGetPokemonDetail {
  final IPokemonRepository _repository;

  GetPokemonDetail(this._repository);

  /// Call method to execute the use case
  @override
  Future<Result<PokemonEntity>> call(int id) async {
    try {
      final result = await _repository.getPokemonById(id);
      return result;
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}

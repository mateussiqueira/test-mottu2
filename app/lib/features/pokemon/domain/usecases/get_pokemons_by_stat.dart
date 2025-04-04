import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../core/result/result.dart';
import '../../entities/pokemon_entity.dart';
import '../../repositories/i_pokemon_repository.dart';

/// Use case to get Pokemon by stat
class GetPokemonsByStat {
  final IPokemonRepository _repository;

  GetPokemonsByStat(this._repository);

  /// Call method to execute the use case
  Future<Result<List<PokemonEntity>>> call(String stat, int value) async {
    try {
      final result = await _repository.getPokemonsByStat(stat, value);
      return result;
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}

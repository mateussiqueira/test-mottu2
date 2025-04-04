import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../core/result/result.dart';
import '../../entities/pokemon_entity.dart';
import '../../repositories/i_pokemon_repository.dart';

/// Use case to get Pokemon by evolution
class GetPokemonsByEvolution {
  final IPokemonRepository _repository;

  GetPokemonsByEvolution(this._repository);

  /// Call method to execute the use case
  Future<Result<List<PokemonEntity>>> call(String evolution) async {
    try {
      final result = await _repository.getPokemonsByEvolution(evolution);
      return result;
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}

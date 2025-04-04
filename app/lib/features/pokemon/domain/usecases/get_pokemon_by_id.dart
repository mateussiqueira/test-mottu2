import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../core/result/result.dart';
import '../../entities/pokemon_entity.dart';
import '../../repositories/i_pokemon_repository.dart';

/// Use case to get a Pokemon by ID
class GetPokemonById {
  final IPokemonRepository _repository;

  GetPokemonById(this._repository);

  /// Call method to execute the use case
  Future<Result<PokemonEntity>> call(int id) async {
    try {
      final result = await _repository.getPokemonById(id);
      return result;
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}

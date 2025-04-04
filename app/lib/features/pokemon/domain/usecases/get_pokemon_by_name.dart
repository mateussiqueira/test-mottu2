import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../core/result/result.dart';
import '../../entities/pokemon_entity.dart';
import '../../repositories/i_pokemon_repository.dart';

/// Use case to get Pokemon by name
class GetPokemonByName {
  final IPokemonRepository _repository;

  GetPokemonByName(this._repository);

  /// Call method to execute the use case
  Future<Result<PokemonEntity>> call(String name) async {
    try {
      final result = await _repository.getPokemonById(int.parse(name));
      return result;
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}

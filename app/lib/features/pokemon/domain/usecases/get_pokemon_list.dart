import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../core/result/result.dart';
import '../../entities/pokemon_entity.dart';
import '../../repositories/i_pokemon_repository.dart';
import 'i_get_pokemon_list.dart';

/// Use case to get a list of Pokemon
class GetPokemonList implements IGetPokemonList {
  final IPokemonRepository _repository;

  GetPokemonList(this._repository);

  /// Call method to execute the use case
  @override
  Future<Result<List<PokemonEntity>>> call({
    int? limit,
    int? offset,
  }) async {
    try {
      final result = await _repository.getPokemonList(
        limit: limit,
        offset: offset,
      );
      return result;
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}

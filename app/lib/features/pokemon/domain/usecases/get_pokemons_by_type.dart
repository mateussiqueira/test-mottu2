import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../core/result/result.dart';
import '../../entities/pokemon_entity.dart';
import '../../repositories/i_pokemon_repository.dart';
import 'i_get_pokemons_by_type.dart';

/// Use case to get Pokemon by type
class GetPokemonsByType implements IGetPokemonsByType {
  final IPokemonRepository _repository;

  GetPokemonsByType(this._repository);

  @override
  Future<Result<List<PokemonEntity>>> call(String type) async {
    try {
      final result = await _repository.getPokemonsByType(type);
      return result;
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}

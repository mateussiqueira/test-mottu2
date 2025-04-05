import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/result/result.dart';
import '../entities/pokemon_entity.dart';
import '../repositories/i_pokemon_repository.dart';
import 'i_get_pokemon_detail_usecase.dart';

/// Implementation of the GetPokemonDetail use case
class GetPokemonDetailUseCase implements IGetPokemonDetailUseCase {
  final IPokemonRepository _repository;

  GetPokemonDetailUseCase(this._repository);

  @override
  Future<Result<PokemonEntity>> call(int id) async {
    try {
      final result = await _repository.getPokemonById(id);
      return result;
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  String toString() => 'GetPokemonDetailUseCase()';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GetPokemonDetailUseCase && other._repository == _repository;
  }

  @override
  int get hashCode => _repository.hashCode;
}

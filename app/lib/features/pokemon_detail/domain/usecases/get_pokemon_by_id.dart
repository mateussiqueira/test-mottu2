import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../pokemon/domain/entities/pokemon_entity.dart';
import '../repositories/pokemon_detail_repository.dart';

class GetPokemonById {
  final PokemonDetailRepository _repository;

  GetPokemonById({
    required PokemonDetailRepository repository,
  }) : _repository = repository;

  Future<Either<Failure, PokemonEntity>> call(int id) async {
    try {
      return await _repository.getPokemonById(id);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}

import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../pokemon/domain/entities/pokemon_entity.dart';
import '../repositories/i_pokemon_detail_repository.dart';
import 'i_get_pokemons_by_type.dart';

class GetPokemonsByType implements IGetPokemonsByType {
  final IPokemonDetailRepository repository;

  GetPokemonsByType({
    required this.repository,
  });

  @override
  Future<Either<Failure, List<PokemonEntity>>> call(String type) async {
    try {
      return await repository.getPokemonsByType(type);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}

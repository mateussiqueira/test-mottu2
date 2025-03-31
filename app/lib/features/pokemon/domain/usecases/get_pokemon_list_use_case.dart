import 'package:mobile/core/domain/result.dart';

import '../entities/pokemon_entity.dart';
import '../repositories/pokemon_repository.dart';

class GetPokemonListUseCase {
  final PokemonRepository repository;

  GetPokemonListUseCase(this.repository);

  Future<Result<List<PokemonEntity>>> call(int limit, int offset) async {
    return repository.getPokemonList(limit: limit, offset: offset);
  }
}

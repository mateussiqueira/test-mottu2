import 'package:mobile/core/domain/result.dart';

import '../entities/pokemon_entity.dart';
import '../repositories/pokemon_repository.dart';

class SearchPokemonUseCase {
  final PokemonRepository repository;

  SearchPokemonUseCase(this.repository);

  Future<Future<Result<List<PokemonEntity>>>> call(String query) async {
    return repository.searchPokemon(query);
  }
}

import '../../../../features/pokemon/domain/entities/pokemon_entity.dart';
import '../../../../features/pokemon/domain/repositories/pokemon_repository.dart';

class GetPokemonList {
  final PokemonRepository repository;

  GetPokemonList({
    required this.repository,
  });

  Future<List<PokemonEntity>> call() async {
    return await repository.getPokemons();
  }
}

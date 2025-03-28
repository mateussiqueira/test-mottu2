import '../../../../core/domain/entities/pokemon.dart';
import '../repositories/pokemon_repository.dart';

class GetPokemonsUseCase {
  final PokemonRepository repository;

  GetPokemonsUseCase(this.repository);

  Future<List<Pokemon>> call({int offset = 0, int limit = 20}) async {
    return repository.getPokemons(offset: offset, limit: limit);
  }
}

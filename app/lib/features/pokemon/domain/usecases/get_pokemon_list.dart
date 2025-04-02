import '../entities/pokemon_entity.dart';
import '../repositories/i_pokemon_repository.dart';

class GetPokemonList {
  final IPokemonRepository repository;

  GetPokemonList(this.repository);

  Future<List<PokemonEntity>> call() async {
    final result = await repository.getPokemonList();
    if (result.isSuccess && result.data != null) {
      return result.data!;
    }
    throw Exception(result.error?.toString() ?? 'Unknown error');
  }
}

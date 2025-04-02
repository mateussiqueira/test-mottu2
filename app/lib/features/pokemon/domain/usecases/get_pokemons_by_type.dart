import '../entities/pokemon_entity.dart';
import '../repositories/i_pokemon_repository.dart';

class GetPokemonsByType {
  final IPokemonRepository repository;

  GetPokemonsByType(this.repository);

  Future<List<PokemonEntity>> call(String type) async {
    final result = await repository.getPokemonsByType(type);
    if (result.isSuccess && result.data != null) {
      return result.data!;
    }
    throw Exception(result.error?.toString() ?? 'Unknown error');
  }
}

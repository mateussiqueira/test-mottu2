import '../entities/pokemon_entity.dart';
import '../repositories/i_pokemon_repository.dart';

class GetPokemonDetail {
  final IPokemonRepository repository;

  GetPokemonDetail(this.repository);

  Future<PokemonEntity> call(int id) async {
    final result = await repository.getPokemonDetail(id);
    if (result.isSuccess && result.data != null) {
      return result.data!;
    }
    throw Exception(result.error?.toString() ?? 'Unknown error');
  }
}

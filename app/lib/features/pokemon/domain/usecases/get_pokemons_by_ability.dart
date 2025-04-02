import '../entities/pokemon_entity.dart';
import '../repositories/i_pokemon_repository.dart';

class GetPokemonsByAbility {
  final IPokemonRepository repository;

  GetPokemonsByAbility(this.repository);

  Future<List<PokemonEntity>> call(String ability) async {
    final result = await repository.getPokemonsByAbility(ability);
    if (result.isSuccess && result.data != null) {
      return result.data!;
    }
    throw Exception(result.error?.toString() ?? 'Unknown error');
  }
}

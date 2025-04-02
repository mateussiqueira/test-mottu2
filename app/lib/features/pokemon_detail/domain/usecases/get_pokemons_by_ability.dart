import '../../../pokemon/domain/entities/pokemon_entity.dart';
import '../repositories/i_pokemon_detail_repository.dart';
import 'i_get_pokemons_by_ability.dart';

class GetPokemonsByAbility implements IGetPokemonsByAbility {
  final IPokemonDetailRepository repository;

  GetPokemonsByAbility({
    required this.repository,
  });

  @override
  Future<List<PokemonEntity>> call(String ability) async {
    final result = await repository.getPokemonsByAbility(ability);
    if (result.isSuccess && result.data != null) {
      return result.data!;
    }
    throw Exception(result.error?.toString() ?? 'Unknown error');
  }
}

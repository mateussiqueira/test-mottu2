import '../../../pokemon/domain/entities/pokemon_entity.dart';
import '../repositories/i_pokemon_detail_repository.dart';
import 'i_get_pokemons_by_type.dart';

class GetPokemonsByType implements IGetPokemonsByType {
  final IPokemonDetailRepository repository;

  GetPokemonsByType({
    required this.repository,
  });

  @override
  Future<List<PokemonEntity>> call(String type) async {
    final result = await repository.getPokemonsByType(type);
    if (result.isSuccess && result.data != null) {
      return result.data!;
    }
    throw Exception(result.error?.toString() ?? 'Unknown error');
  }
}

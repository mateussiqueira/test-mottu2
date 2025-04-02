import '../../../../features/pokemon/domain/entities/pokemon_entity.dart';
import '../../../../features/pokemon/domain/repositories/pokemon_repository.dart';

class GetPokemonDetail {
  final PokemonRepository repository;

  GetPokemonDetail(this.repository);

  Future<PokemonEntity> call(int id) async {
    final result = await repository.getPokemonDetail(id);
    if (result.isSuccess && result.data != null) {
      return result.data!;
    }
    throw Exception(result.error?.toString() ?? 'Unknown error');
  }
}

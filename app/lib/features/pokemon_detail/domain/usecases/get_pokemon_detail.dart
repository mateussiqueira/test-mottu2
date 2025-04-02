import '../../../pokemon/domain/entities/i_pokemon_entity.dart';
import '../../../pokemon/domain/repositories/i_pokemon_repository.dart';
import 'i_get_pokemon_detail.dart';

/// Use case for getting Pokemon details
class GetPokemonDetail implements IGetPokemonDetail {
  final IPokemonRepository repository;

  GetPokemonDetail(this.repository);

  @override
  Future<IPokemonEntity> call(int id) async {
    final result = await repository.getPokemonDetail(id);
    if (result.isSuccess && result.data != null) {
      return result.data!;
    }
    throw Exception(result.error?.toString() ?? 'Unknown error');
  }
}

import 'package:mobile/features/pokemon/domain/entities/pokemon_entity.dart';
import 'package:mobile/features/pokemon_detail/domain/repositories/pokemon_detail_repository.dart';

class GetPokemonById {
  final PokemonDetailRepository repository;

  GetPokemonById({
    required this.repository,
  });

  Future<PokemonEntity> call(int id) async {
    return await repository.getPokemonById(id);
  }
}

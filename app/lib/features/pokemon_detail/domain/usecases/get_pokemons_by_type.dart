import 'package:mobile/features/pokemon/domain/entities/pokemon_entity.dart';
import 'package:mobile/features/pokemon_detail/domain/repositories/pokemon_detail_repository.dart';

class GetPokemonsByType {
  final PokemonDetailRepository repository;

  GetPokemonsByType({
    required this.repository,
  });

  Future<List<PokemonEntity>> call(String type) async {
    return await repository.getPokemonsByType(type);
  }
}

import 'package:mobile/features/pokemon/domain/entities/pokemon_entity.dart';
import 'package:mobile/features/pokemon_detail/domain/repositories/pokemon_detail_repository.dart';

class GetPokemonsByAbility {
  final PokemonDetailRepository repository;

  GetPokemonsByAbility({
    required this.repository,
  });

  Future<List<PokemonEntity>> call(String ability) async {
    return await repository.getPokemonsByAbility(ability);
  }
}

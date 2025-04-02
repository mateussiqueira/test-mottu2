import 'package:mobile/core/domain/result.dart';
import 'package:mobile/features/pokemon/domain/entities/pokemon_entity.dart';
import 'package:mobile/features/pokemon_list/domain/repositories/pokemon_repository.dart';

class GetPokemonDetailUseCase {
  final PokemonRepository _repository;

  GetPokemonDetailUseCase(this._repository);

  /// Executa o caso de uso
  Future<Result<PokemonEntityImpl>> call(int id) async {
    return _repository.getPokemonDetail(id);
  }
}

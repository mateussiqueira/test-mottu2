import '../../../../core/logging/i_logger.dart';
import '../../../pokemon/domain/repositories/i_pokemon_repository.dart';
import '../../domain/repositories/i_pokemon_detail_repository.dart';

abstract class IPokemonDetailUseCases {
  ILogger get logger;
  IPokemonRepository get pokemonRepository;
  IPokemonDetailRepository get detailRepository;
  void registerUseCases();
}

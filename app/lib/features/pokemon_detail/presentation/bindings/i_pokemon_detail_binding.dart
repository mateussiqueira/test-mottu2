import 'package:get/get.dart';

import '../../../../core/logging/i_logger.dart';
import '../../../pokemon/domain/repositories/i_pokemon_repository.dart';
import '../../domain/repositories/i_pokemon_detail_repository.dart';

abstract class IPokemonDetailBinding extends Bindings {
  ILogger get logger;
  IPokemonRepository get pokemonRepository;
  IPokemonDetailRepository get detailRepository;
}

import 'package:get_it/get_it.dart';

import 'i_logger.dart';
import 'pokemon_logger.dart';

class LoggingModule {
  static void setup(GetIt getIt) {
    getIt.registerLazySingleton<ILogger>(
      () => PokemonLogger(),
    );
  }
}

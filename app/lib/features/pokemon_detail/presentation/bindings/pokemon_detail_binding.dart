import 'package:get/get.dart';

import '../../../../core/config/di.dart';
import '../../../../core/logging/i_logger.dart';
import '../../../../core/performance/i_performance_monitor.dart';
import '../../../pokemon/domain/repositories/i_pokemon_repository.dart';
import '../controllers/i_pokemon_detail_controller.dart';
import '../controllers/pokemon_detail_controller.dart';

class PokemonDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IPokemonDetailController>(
      () => PokemonDetailController(
        repository: getIt<IPokemonRepository>(),
        logger: getIt<ILogger>(),
        performanceMonitor: getIt<IPerformanceMonitor>(),
      ),
    );
  }
}

import 'package:get/get.dart';

import '../../../../core/logging/i_logger.dart';
import '../../../../core/performance/i_performance_monitor.dart';
import '../../../pokemon/domain/repositories/i_pokemon_repository.dart';

abstract class IPokemonListBinding extends Bindings {
  ILogger get logger;
  IPerformanceMonitor get performanceMonitor;
  IPokemonRepository get repository;
}

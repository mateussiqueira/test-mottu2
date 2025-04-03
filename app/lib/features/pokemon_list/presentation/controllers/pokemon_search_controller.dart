import 'dart:isolate';

import 'package:get/get.dart';

import '../../../../core/constants/route_names.dart';
import '../../../../core/domain/errors/error_handler.dart';
import '../../../../core/domain/errors/i_logger.dart';
import '../../../../core/domain/errors/performance_monitor.dart';
import '../../../../features/pokemon/domain/entities/pokemon_entity.dart';
import '../services/pokemon_search_isolate.dart';
import 'i_pokemon_search_controller.dart';

class PokemonSearchController extends GetxController
    implements IPokemonSearchController {
  final ErrorHandler _errorHandler;
  final PerformanceMonitor _performanceMonitor;
  final ILogger _logger;

  @override
  final RxList<PokemonEntity> searchResults = <PokemonEntity>[].obs;
  @override
  final RxBool isLoading = false.obs;
  final RxString _error = ''.obs;
  @override
  final RxString lastQuery = ''.obs;

  @override
  String? get error => _error.value.isEmpty ? null : _error.value;

  PokemonSearchController({
    required ErrorHandler errorHandler,
    required PerformanceMonitor performanceMonitor,
    required ILogger logger,
  })  : _errorHandler = errorHandler,
        _performanceMonitor = performanceMonitor,
        _logger = logger;

  @override
  Future<void> search(String query) async {
    if (query.isEmpty) {
      clearSearch();
      return;
    }

    if (query == lastQuery.value) {
      return;
    }

    lastQuery.value = query;
    isLoading.value = true;
    _error.value = '';

    try {
      final receivePort = ReceivePort();
      final isolate = await Isolate.spawn(
        PokemonSearchIsolate.searchInIsolate,
        receivePort.sendPort,
      );

      final isolateSendPort = await receivePort.first as SendPort;
      isolateSendPort.send(query);

      final result = await receivePort.first;
      receivePort.close();
      isolate.kill();

      if (result is List<PokemonEntity>) {
        searchResults.value = result;
      } else if (result is Exception) {
        _error.value = result.toString();
        _logger.error('Error searching Pokemon', result);
      }
    } catch (e, stackTrace) {
      _error.value = e.toString();
      _logger.error('Error searching Pokemon', e, stackTrace);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void clearSearch() {
    searchResults.clear();
    lastQuery.value = '';
    _error.value = '';
  }

  @override
  void navigateToDetail(PokemonEntity pokemon) {
    Get.toNamed(
      RouteNames.pokemonDetail,
      arguments: {
        'pokemon': pokemon,
        'fromSearch': true,
      },
    );
  }

  @override
  void onClose() {
    searchResults.close();
    super.onClose();
  }
}

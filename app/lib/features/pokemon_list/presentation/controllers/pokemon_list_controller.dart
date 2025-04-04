import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pokemon_list/features/pokemon_list/domain/services/type_service.dart';

import '../../../../core/constants/route_names.dart';
import '../../../../core/domain/errors/error_handler.dart';
import '../../../../core/domain/errors/i_logger.dart';
import '../../../../core/domain/errors/performance_monitor.dart';
import '../../../../features/pokemon/domain/entities/pokemon_entity.dart';
import '../services/pokemon_search_isolate.dart';
import 'i_pokemon_list_controller.dart';
import 'i_pokemon_search_controller.dart';
import 'pokemon_list_state.dart';

/// Controller for managing the Pokemon list page
class PokemonListController extends GetxController
    implements IPokemonListController, IPokemonSearchController {
  final ErrorHandler _errorHandler;
  final PerformanceMonitor _performanceMonitor;
  final ILogger _logger;
  final PokemonListState _state = PokemonListState();
  final ScrollController scrollController = ScrollController();
  final int _pageSize = 20;
  int _currentPage = 0;
  bool _hasMore = true;
  bool _isLoadingMore = false;
  final Map<int, List<PokemonEntity>> _cache = {};
  final TypeService _typeService = TypeService();

  @override
  PokemonListState get state => _state;

  @override
  RxList<PokemonEntity> get pokemons => _state.pokemons;

  @override
  bool get isLoadingMore => _isLoadingMore;

  @override
  int get currentPage => _currentPage;

  @override
  bool get hasMore => _hasMore;

  @override
  String get searchQuery => _state.searchQuery.value;

  @override
  String get filterType => _state.filterType.value;

  @override
  String get filterAbility => _state.filterAbility.value;

  @override
  bool get hasError => _state.error.value.isNotEmpty;

  @override
  final RxList<PokemonEntity> searchResults = <PokemonEntity>[].obs;
  @override
  final RxBool isLoading = false.obs;
  @override
  final RxString lastQuery = ''.obs;

  @override
  String? get error => _state.error.value.isEmpty ? null : _state.error.value;

  PokemonListController({
    required ErrorHandler errorHandler,
    required PerformanceMonitor performanceMonitor,
    required ILogger logger,
  })  : _errorHandler = errorHandler,
        _performanceMonitor = performanceMonitor,
        _logger = logger {
    scrollController.addListener(_onScroll);
  }

  @override
  void onInit() {
    super.onInit();
    fetchPokemonList();
  }

  void _onScroll() {
    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 200 &&
        !_isLoadingMore &&
        _hasMore) {
      loadMore();
    }
  }

  @override
  Future<void> loadMore() async {
    if (_isLoadingMore || !_hasMore) return;

    _isLoadingMore = true;
    _state.isLoadingMore.value = true;
    _currentPage++;

    try {
      final pokemons = await _getPokemonsByPage(_currentPage);
      if (pokemons.isEmpty) {
        _hasMore = false;
        _state.hasMore.value = false;
      } else {
        _cache[_currentPage] = pokemons;
        _state.pokemons.addAll(pokemons);
      }
    } catch (e, stackTrace) {
      _logger.error('Error loading more Pokemons', e, stackTrace);
      _state.error.value = e.toString();
    } finally {
      _isLoadingMore = false;
      _state.isLoadingMore.value = false;
    }
  }

  Future<List<PokemonEntity>> _getPokemonsByPage(int page) async {
    if (_cache.containsKey(page)) {
      return _cache[page]!;
    }

    final start = page * _pageSize;
    final end = start + _pageSize;
    final pokemons = <PokemonEntity>[];

    for (int i = start; i < end; i++) {
      try {
        final pokemon = await _getPokemonById(i + 1);
        pokemons.add(pokemon);
      } catch (e) {
        _logger.error('Error loading Pokemon $i', e);
      }
    }

    return pokemons;
  }

  Future<PokemonEntity> _getPokemonById(int id) async {
    final response = await http.get(
      Uri.parse('https://pokeapi.co/api/v2/pokemon/$id'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final pokemon = PokemonEntity.fromJson(data);
      // Since typeRelations is final, we need to handle this in the repository
      return pokemon;
    } else {
      throw Exception('Failed to load Pokemon details');
    }
  }

  @override
  Future<void> fetchPokemonList() async {
    _state.isLoading.value = true;
    _state.error.value = '';

    try {
      _currentPage = 0;
      _hasMore = true;
      _state.hasMore.value = true;
      _cache.clear();
      _state.pokemons.clear();

      final pokemons = await _getPokemonsByPage(_currentPage);
      _cache[_currentPage] = pokemons;
      _state.pokemons.addAll(pokemons);
    } catch (e, stackTrace) {
      _state.error.value = e.toString();
      _logger.error('Error loading Pokemons', e, stackTrace);
    } finally {
      _state.isLoading.value = false;
    }
  }

  @override
  Future<void> search(String query) async {
    if (query.isEmpty) {
      clearSearch();
      return;
    }

    lastQuery.value = query;
    isLoading.value = true;
    _state.error.value = '';

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
        searchResults.clear();
        searchResults.addAll(result);
      } else if (result is Exception) {
        _state.error.value = result.toString();
        _logger.error('Error searching Pokemon', result);
      }
    } catch (e, stackTrace) {
      _state.error.value = e.toString();
      _logger.error('Error searching Pokemon', e, stackTrace);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void clearSearch() {
    searchResults.clear();
    lastQuery.value = '';
    _state.error.value = '';
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
  Future<void> filterByType(String type) async {
    _state.filterType.value = type;
    if (type.isEmpty) {
      await fetchPokemonList();
      return;
    }

    try {
      _state.isLoading.value = true;
      final response = await http.get(
        Uri.parse('https://pokeapi.co/api/v2/type/$type'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final pokemonList = (data['pokemon'] as List<dynamic>)
            .map((pokemon) => pokemon['pokemon']['name'] as String)
            .toList();

        final pokemons = await Future.wait(
          pokemonList.take(20).map((name) => _getPokemonByName(name)),
        );

        _state.pokemons.clear();
        _state.pokemons.addAll(pokemons);
        _state.hasMore.value = false;
      } else {
        throw Exception('Failed to filter Pokemon by type');
      }
    } catch (e, stackTrace) {
      _state.error.value = e.toString();
      _logger.error('Error filtering Pokemon by type', e, stackTrace);
    } finally {
      _state.isLoading.value = false;
    }
  }

  Future<PokemonEntity> _getPokemonByName(String name) async {
    final response = await http.get(
      Uri.parse('https://pokeapi.co/api/v2/pokemon/$name'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return PokemonEntity.fromJson(data);
    } else {
      throw Exception('Failed to load Pokemon details');
    }
  }

  @override
  Future<void> filterByAbility(String ability) async {
    _state.filterAbility.value = ability;
    if (ability.isEmpty) {
      await fetchPokemonList();
      return;
    }

    try {
      _state.isLoading.value = true;
      final response = await http.get(
        Uri.parse('https://pokeapi.co/api/v2/ability/$ability'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final pokemonList = (data['pokemon'] as List<dynamic>)
            .map((pokemon) => pokemon['pokemon']['name'] as String)
            .toList();

        final pokemons = await Future.wait(
          pokemonList.take(20).map((name) => _getPokemonByName(name)),
        );

        _state.pokemons.clear();
        _state.pokemons.addAll(pokemons);
        _state.hasMore.value = false;
      } else {
        throw Exception('Failed to filter Pokemon by ability');
      }
    } catch (e, stackTrace) {
      _state.error.value = e.toString();
      _logger.error('Error filtering Pokemon by ability', e, stackTrace);
    } finally {
      _state.isLoading.value = false;
    }
  }

  @override
  void clearFilters() {
    _state.filterType.value = '';
    _state.filterAbility.value = '';
    fetchPokemonList();
  }

  @override
  void onClose() {
    scrollController.dispose();
    searchResults.close();
    super.onClose();
  }
}

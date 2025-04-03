import 'dart:convert';
import 'dart:isolate';

import 'package:http/http.dart' as http;

import '../../../../core/domain/errors/i_logger.dart';
import '../../../../core/domain/errors/i_performance_monitor.dart';
import '../../../../core/domain/errors/logger.dart';
import '../../../../core/domain/errors/performance_monitor.dart';
import '../../../../features/pokemon/domain/entities/pokemon_entity.dart';

class PokemonSearchIsolate {
  static final ILogger _logger = Logger();
  static final IPerformanceMonitor _performanceMonitor = PerformanceMonitor();

  static Future<List<PokemonEntity>> searchPokemons(String query) async {
    final startTime = DateTime.now();
    try {
      // First, get all Pokemon names that match the query
      final response = await http.get(
        Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=1118'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['results'] as List;

        // Filter results based on query
        final matchingPokemons = results.where((result) {
          final name = result['name'].toString().toLowerCase();
          return name.contains(query.toLowerCase());
        }).toList();

        // Get details for matching Pokemons in parallel
        final pokemons = <PokemonEntity>[];
        await Future.wait(
          matchingPokemons.map((result) async {
            final id = int.parse(result['url'].split('/')[6]);
            try {
              final pokemon = await _getPokemonById(id);
              pokemons.add(pokemon);
            } catch (e) {
              _logger.error('Error loading Pokemon details', e);
            }
          }),
        );

        _performanceMonitor.end('searchPokemons');
        return pokemons;
      } else {
        throw Exception('Failed to search Pokemon');
      }
    } catch (e) {
      _performanceMonitor.end('searchPokemons');
      rethrow;
    }
  }

  static Future<PokemonEntity> _getPokemonById(int id) async {
    final response = await http.get(
      Uri.parse('https://pokeapi.co/api/v2/pokemon/$id'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return PokemonEntity.fromJson(data);
    } else {
      throw Exception('Failed to load Pokemon details');
    }
  }

  static Future<void> searchInIsolate(SendPort sendPort) async {
    final receivePort = ReceivePort();

    sendPort.send(receivePort.sendPort);

    await for (final message in receivePort) {
      if (message is String) {
        try {
          final pokemons = await searchPokemons(message);
          sendPort.send(pokemons);
        } catch (e, stackTrace) {
          _logger.error('Error searching Pokemon in isolate', e, stackTrace);
          sendPort.send(e);
        }
      }
    }

    receivePort.close();
  }
}

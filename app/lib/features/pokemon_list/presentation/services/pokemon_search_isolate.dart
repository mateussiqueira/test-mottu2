import 'dart:isolate';

import 'package:flutter/foundation.dart';

import '../../domain/entities/i_pokemon_entity.dart';
import '../../domain/repositories/i_pokemon_repository.dart';

class PokemonSearchIsolate {
  static Future<List<IPokemonEntity>> searchPokemons(
    String query,
    IPokemonRepository repository,
  ) async {
    final receivePort = ReceivePort();
    final isolate = await Isolate.spawn(
      _searchInIsolate,
      _SearchParams(
        query: query,
        repository: repository,
        sendPort: receivePort.sendPort,
      ),
    );

    final result = await receivePort.first;
    receivePort.close();
    isolate.kill();

    return result;
  }

  static Future<void> _searchInIsolate(_SearchParams params) async {
    try {
      final result = await params.repository.searchPokemons(params.query);
      if (result.isSuccess) {
        params.sendPort.send(result.data ?? []);
      } else {
        params.sendPort.send([]);
      }
    } catch (e) {
      params.sendPort.send([]);
    }
  }
}

class _SearchParams {
  final String query;
  final IPokemonRepository repository;
  final SendPort sendPort;

  _SearchParams({
    required this.query,
    required this.repository,
    required this.sendPort,
  });
}

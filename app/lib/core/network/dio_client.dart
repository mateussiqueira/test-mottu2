import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class DioClient {
  final Dio _dio;
  final DefaultCacheManager _cacheManager;

  DioClient()
      : _dio = Dio(
          BaseOptions(
            baseUrl: 'https://pokeapi.co/api/v2',
            connectTimeout: const Duration(seconds: 5),
            receiveTimeout: const Duration(seconds: 3),
          ),
        ),
        _cacheManager = DefaultCacheManager();

  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    bool useCache = true,
  }) async {
    final fullUrl =
        path.startsWith('http') ? path : '${_dio.options.baseUrl}$path';
    final cacheKey = _generateCacheKey(fullUrl, queryParameters);

    if (useCache) {
      final cachedData = await _getCachedData(cacheKey);
      if (cachedData != null) {
        return cachedData;
      }
    }

    try {
      final response = await _dio.get(
        path.startsWith('http') ? path : path,
        queryParameters: queryParameters,
      );

      if (useCache) {
        await _cacheResponse(cacheKey, jsonEncode(response.data));
      }

      return response.data;
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }

  Future<dynamic> _getCachedData(String key) async {
    try {
      final fileInfo = await _cacheManager.getFileFromCache(key);
      if (fileInfo == null) {
        return null;
      }

      final file = fileInfo.file;
      final contents = await file.readAsString();
      return jsonDecode(contents);
    } catch (e) {
      return null;
    }
  }

  Future<void> _cacheResponse(String key, String data) async {
    try {
      final bytes = Uint8List.fromList(utf8.encode(data));
      await _cacheManager.putFile(
        key,
        bytes,
        maxAge: const Duration(hours: 1),
      );
    } catch (e) {
      // Ignore cache errors
    }
  }

  String _generateCacheKey(String path, Map<String, dynamic>? queryParameters) {
    var key = path;
    if (queryParameters != null && queryParameters.isNotEmpty) {
      final queryString =
          queryParameters.entries.map((e) => '${e.key}=${e.value}').join('&');
      key += '?$queryString';
    }
    return key;
  }
}

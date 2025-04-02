import 'dart:collection';

import 'package:get/get.dart';

class PokemonCacheManager extends GetxService {
  static const int maxCacheSize = 100;
  final Map<String, CacheEntry> _cache = {};
  final Queue<String> _accessOrder = Queue();

  T? get<T>(String key) {
    final entry = _cache[key];
    if (entry == null || entry.isExpired) {
      _cache.remove(key);
      _accessOrder.remove(key);
      return null;
    }

    _updateAccessOrder(key);
    return entry.data as T;
  }

  void set<T>(String key, T data, {Duration? duration}) {
    if (_cache.length >= maxCacheSize) {
      _evictOldest();
    }

    _cache[key] = CacheEntry(
      data: data,
      timestamp: DateTime.now(),
      duration: duration,
    );
    _updateAccessOrder(key);
  }

  void _updateAccessOrder(String key) {
    _accessOrder.remove(key);
    _accessOrder.addLast(key);
  }

  void _evictOldest() {
    if (_accessOrder.isNotEmpty) {
      final oldestKey = _accessOrder.removeFirst();
      _cache.remove(oldestKey);
    }
  }

  void clear() {
    _cache.clear();
    _accessOrder.clear();
  }
}

class CacheEntry {
  final dynamic data;
  final DateTime timestamp;
  final Duration? duration;

  CacheEntry({
    required this.data,
    required this.timestamp,
    this.duration,
  });

  bool get isExpired {
    if (duration == null) return false;
    return DateTime.now().difference(timestamp) > duration!;
  }
}

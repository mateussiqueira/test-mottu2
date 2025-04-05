import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class ImageCacheService {
  final cacheManager = DefaultCacheManager();

  Future<void> precacheImage(String url) async {
    await cacheManager.getSingleFile(url);
  }

  Future<void> clearCache() async {
    await cacheManager.emptyCache();
  }
}
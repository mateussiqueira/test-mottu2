import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageCacheService {
  static final ImageCacheService _instance = ImageCacheService._internal();
  factory ImageCacheService() => _instance;
  ImageCacheService._internal();

  Widget getCachedImage({
    required String imageUrl,
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    Widget? placeholder,
    Widget? errorWidget,
  }) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, url) =>
          placeholder ??
          const Center(
            child: CircularProgressIndicator(),
          ),
      errorWidget: (context, url, error) =>
          errorWidget ??
          const Icon(
            Icons.error_outline,
            color: Colors.red,
          ),
      memCacheWidth: 300, // Otimiza o tamanho do cache em memória
      memCacheHeight: 300,
      maxWidthDiskCache: 300, // Otimiza o tamanho do cache em disco
      maxHeightDiskCache: 300,
      fadeInDuration: const Duration(milliseconds: 300),
      fadeOutDuration: const Duration(milliseconds: 300),
    );
  }

  Future<void> clearImageCache() async {
    await CachedNetworkImage.evictFromCache('*');
  }
}

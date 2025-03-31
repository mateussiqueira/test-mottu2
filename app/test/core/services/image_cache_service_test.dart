import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/core/services/image_cache_service.dart';
import 'package:mockito/mockito.dart';

import '../../../test/mocks.mocks.dart';

void main() {
  late ImageCacheService imageCacheService;
  late MockSharedPreferences mockPrefs;

  setUp(() {
    mockPrefs = MockSharedPreferences();
    imageCacheService = ImageCacheService(preferences: mockPrefs);
  });

  group('ImageCacheService', () {
    test('should cache image', () async {
      const imageUrl = 'https://example.com/bulbasaur.png';
      const imageData = 'base64_encoded_image_data';

      when(mockPrefs.setString('image_$imageUrl', imageData))
          .thenAnswer((_) async => true);
      when(mockPrefs.setInt('image_${imageUrl}_timestamp', any))
          .thenAnswer((_) async => true);

      await imageCacheService.saveImage(
        imageUrl: imageUrl,
        imageData: imageData,
      );

      verify(mockPrefs.setString('image_$imageUrl', imageData)).called(1);
      verify(mockPrefs.setInt('image_${imageUrl}_timestamp', any)).called(1);
    });

    test('should get cached image', () async {
      const imageUrl = 'https://example.com/bulbasaur.png';
      const imageData = 'base64_encoded_image_data';

      when(mockPrefs.getString('image_$imageUrl')).thenReturn(imageData);
      when(mockPrefs.getInt('image_${imageUrl}_timestamp'))
          .thenReturn(DateTime.now().millisecondsSinceEpoch);

      final cachedImage = imageCacheService.getImage(imageUrl: imageUrl);

      expect(cachedImage, isNotNull);
      expect(cachedImage, imageData);
    });

    test('should return null when cache is expired', () async {
      const imageUrl = 'https://example.com/bulbasaur.png';

      when(mockPrefs.getString('image_$imageUrl'))
          .thenReturn('base64_encoded_image_data');
      when(mockPrefs.getInt('image_${imageUrl}_timestamp')).thenReturn(
        DateTime.now()
            .subtract(const Duration(hours: 2))
            .millisecondsSinceEpoch,
      );

      final cachedImage = imageCacheService.getImage(imageUrl: imageUrl);

      expect(cachedImage, isNull);
    });

    test('should clear image cache', () async {
      const imageUrl = 'https://example.com/bulbasaur.png';

      when(mockPrefs.remove('image_$imageUrl')).thenAnswer((_) async => true);
      when(mockPrefs.remove('image_${imageUrl}_timestamp'))
          .thenAnswer((_) async => true);

      await imageCacheService.clearImage(imageUrl: imageUrl);

      verify(mockPrefs.remove('image_$imageUrl')).called(1);
      verify(mockPrefs.remove('image_${imageUrl}_timestamp')).called(1);
    });

    test('should clear all image cache', () async {
      when(mockPrefs.getKeys()).thenReturn({
        'image_https://example.com/bulbasaur.png',
        'image_https://example.com/bulbasaur.png_timestamp',
        'image_https://example.com/charmander.png',
        'image_https://example.com/charmander.png_timestamp',
      });

      when(mockPrefs.remove(any)).thenAnswer((_) async => true);

      await imageCacheService.clearAllImages();

      verify(mockPrefs.remove(any)).called(4);
    });
  });
}

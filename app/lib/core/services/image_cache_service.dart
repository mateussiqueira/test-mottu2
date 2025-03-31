import 'package:shared_preferences/shared_preferences.dart';

class ImageCacheService {
  final SharedPreferences preferences;
  static const _cacheExpirationHours = 1;

  ImageCacheService({required this.preferences});

  Future<void> saveImage({
    required String imageUrl,
    required String imageData,
  }) async {
    await preferences.setString('image_$imageUrl', imageData);
    await preferences.setInt(
      'image_${imageUrl}_timestamp',
      DateTime.now().millisecondsSinceEpoch,
    );
  }

  String? getImage({required String imageUrl}) {
    final timestamp = preferences.getInt('image_${imageUrl}_timestamp');
    if (timestamp == null) return null;

    final expirationDate = DateTime.fromMillisecondsSinceEpoch(timestamp)
        .add(const Duration(hours: _cacheExpirationHours));
    if (DateTime.now().isAfter(expirationDate)) return null;

    return preferences.getString('image_$imageUrl');
  }

  Future<void> clearImage({required String imageUrl}) async {
    await preferences.remove('image_$imageUrl');
    await preferences.remove('image_${imageUrl}_timestamp');
  }

  Future<void> clearAllImages() async {
    final keys = preferences.getKeys();
    final imageKeys = keys.where((key) => key.startsWith('image_'));
    for (final key in imageKeys) {
      await preferences.remove(key);
    }
  }
}

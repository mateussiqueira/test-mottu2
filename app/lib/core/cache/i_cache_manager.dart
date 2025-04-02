abstract class ICacheManager {
  Future<dynamic> get(String key);
  Future<void> set(String key, dynamic value);
  Future<void> remove(String key);
  Future<void> clear();
  Future<void> delete(String key);
  Future<bool> has(String key);
  Future<void> save(String key, dynamic value);
}

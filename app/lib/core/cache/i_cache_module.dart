abstract class ICacheModule {
  Future<void> setup();
  Future<void> set(String key, dynamic value);
  Future<dynamic> get(String key);
  Future<String?> getString(String key);
  Future<int?> getInt(String key);
  Future<double?> getDouble(String key);
  Future<bool?> getBool(String key);
  Future<List<String>?> getStringList(String key);
  Future<void> remove(String key);
  Future<void> clear();
}

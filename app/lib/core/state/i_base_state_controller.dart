abstract class IBaseStateController {
  bool get isLoading;
  String? get error;
  void setLoading(bool value);
  void setError(String? message);
  void clearError();
  Future<T> trackOperation<T>(
    String operation,
    Future<T> Function() action,
  );
}

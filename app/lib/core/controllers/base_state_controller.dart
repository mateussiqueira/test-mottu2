import 'package:get/get.dart';

import '../logging/i_logger.dart';

abstract class BaseStateController<T> extends GetxController {
  final ILogger logger;
  final _isLoading = false.obs;
  final _error = RxnString();
  final _data = Rxn<T>();

  BaseStateController({required this.logger});

  bool get isLoading => _isLoading.value;
  set isLoading(bool value) => _isLoading.value = value;

  String? get error => _error.value;
  set error(String? value) => _error.value = value;

  T? get data => _data.value;
  set data(T? value) => _data.value = value;

  void setLoading(bool value) {
    isLoading = value;
  }

  void setError(String? message) {
    error = message;
  }

  void setData(T? value) {
    data = value;
  }

  void clearError() {
    error = null;
  }

  void clearData() {
    data = null;
  }

  void reset() {
    clearError();
    clearData();
    setLoading(false);
  }
}

import 'package:get/get.dart';

import '../logging/i_logger.dart';
import 'i_reactive_controller.dart';

abstract class BaseReactiveController<T> extends GetxController
    implements IReactiveController<T> {
  final ILogger logger;
  final _isLoading = false.obs;
  final _error = RxnString();
  final _data = Rxn<T>();

  BaseReactiveController({required this.logger});

  @override
  RxBool get isLoadingRx => _isLoading;

  @override
  bool get isLoading => _isLoading.value;

  @override
  set isLoading(bool value) => _isLoading.value = value;

  @override
  RxnString get errorRx => _error;

  @override
  String? get error => _error.value;

  @override
  set error(String? value) => _error.value = value;

  @override
  Rxn<T> get dataRx => _data;

  @override
  T? get data => _data.value;

  @override
  set data(T? value) => _data.value = value;

  @override
  void setLoading(bool value) {
    isLoading = value;
  }

  @override
  void setError(String? message) {
    error = message;
  }

  @override
  void setData(T? value) {
    data = value;
  }

  @override
  void clearError() {
    error = null;
  }

  @override
  void clearData() {
    data = null;
  }

  @override
  void reset() {
    clearError();
    clearData();
    setLoading(false);
  }
}

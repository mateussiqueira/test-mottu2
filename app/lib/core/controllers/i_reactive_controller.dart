import 'package:get/get.dart';

abstract class IReactiveController<T> {
  RxBool get isLoadingRx;
  bool get isLoading;
  set isLoading(bool value);

  RxnString get errorRx;
  String? get error;
  set error(String? value);

  Rxn<T> get dataRx;
  T? get data;
  set data(T? value);

  void setLoading(bool value);
  void setError(String? message);
  void setData(T? value);
  void clearError();
  void clearData();
  void reset();
}

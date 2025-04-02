import 'package:get/get.dart';

import 'i_initial_binding.dart';

abstract class BaseBinding extends Bindings implements IInitialBinding {
  @override
  void dependencies();

  void put<T extends Object>(
    T instance, {
    String? tag,
    bool permanent = false,
  }) {
    Get.put<T>(
      instance,
      tag: tag,
      permanent: permanent,
    );
  }

  void putAsync<T extends Object>(
    Future<T> Function() factory, {
    String? tag,
    bool permanent = false,
  }) {
    Get.putAsync<T>(
      factory,
      tag: tag,
      permanent: permanent,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;

import 'state_management_adapter.dart';

/// Implementação do GetX para gerenciamento de estado e navegação
class GetXAdapter implements StateManagementAdapter {
  static final GetXAdapter _instance = GetXAdapter._internal();
  factory GetXAdapter() => _instance;
  GetXAdapter._internal();

  @override
  Future<T?> toNamed<T>(
    String routeName, {
    dynamic arguments,
    Map<String, String>? parameters,
  }) {
    return getx.Get.toNamed<T>(
          routeName,
          arguments: arguments,
          parameters: parameters,
          preventDuplicates: true,
        ) ??
        Future.value(null);
  }

  @override
  Future<T?> offAllNamed<T>(
    String routeName, {
    dynamic arguments,
    Map<String, String>? parameters,
  }) {
    return getx.Get.offAllNamed<T>(
          routeName,
          arguments: arguments,
          parameters: parameters,
        ) ??
        Future.value(null);
  }

  @override
  Future<T?> pushReplacementNamed<T>(
    String routeName, {
    dynamic arguments,
    Map<String, String>? parameters,
  }) {
    return getx.Get.offAndToNamed<T>(
          routeName,
          arguments: arguments,
          parameters: parameters,
        ) ??
        Future.value(null);
  }

  @override
  void back<T>({T? result}) {
    getx.Get.back<T>(result: result);
  }

  @override
  void put<T>(
    T dependency, {
    String? tag,
    bool permanent = false,
  }) {
    getx.Get.put<T>(
      dependency,
      tag: tag,
      permanent: permanent,
    );
  }

  @override
  void lazyPut<T>(
    T Function() factory, {
    String? tag,
    bool fenix = true,
  }) {
    getx.Get.lazyPut<T>(
      factory,
      tag: tag,
      fenix: fenix,
    );
  }

  @override
  T find<T>({String? tag}) {
    return getx.Get.find<T>(tag: tag);
  }

  @override
  bool isRegistered<T>({String? tag}) {
    return getx.Get.isRegistered<T>(tag: tag);
  }

  @override
  Future<bool> delete<T>({String? tag}) {
    return getx.Get.delete<T>(tag: tag);
  }

  @override
  Future<void> deleteAll() {
    return getx.Get.deleteAll();
  }

  @override
  void showSnackbar({
    required String title,
    required String message,
    SnackPosition position = SnackPosition.BOTTOM,
    Duration duration = const Duration(seconds: 3),
  }) {
    getx.Get.snackbar(
      title,
      message,
      snackPosition: _convertSnackPosition(position),
      duration: duration,
      backgroundColor: Colors.black87,
      colorText: Colors.white,
    );
  }

  @override
  Future<T?> showDialog<T>({
    required String title,
    required String message,
    String? confirmText,
    String? cancelText,
    bool barrierDismissible = true,
  }) {
    return getx.Get.dialog<T>(
      AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          if (cancelText != null)
            TextButton(
              onPressed: () => getx.Get.back(result: false),
              child: Text(cancelText),
            ),
          if (confirmText != null)
            TextButton(
              onPressed: () => getx.Get.back(result: true),
              child: Text(confirmText),
            ),
        ],
      ),
      barrierDismissible: barrierDismissible,
    );
  }

  @override
  Future<T?> showBottomSheet<T>({
    required Widget child,
    bool isScrollControlled = true,
    bool enableDrag = true,
  }) {
    return getx.Get.bottomSheet<T>(
      child,
      isScrollControlled: isScrollControlled,
      enableDrag: enableDrag,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    );
  }

  getx.SnackPosition _convertSnackPosition(SnackPosition position) {
    switch (position) {
      case SnackPosition.TOP:
        return getx.SnackPosition.TOP;
      case SnackPosition.CENTER:
        return getx.SnackPosition
            .BOTTOM; // GetX não tem CENTER, usando BOTTOM como fallback
      case SnackPosition.BOTTOM:
        return getx.SnackPosition.BOTTOM;
      default:
        return getx.SnackPosition.BOTTOM;
    }
  }
}

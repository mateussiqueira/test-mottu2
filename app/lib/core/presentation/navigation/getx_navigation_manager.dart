import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'i_navigation_manager.dart';

class GetXNavigationManager implements INavigationManager {
  @override
  Future<T?> navigateTo<T>(
    String routeName, {
    dynamic arguments,
    Map<String, String>? parameters,
  }) {
    return Get.toNamed<T>(
          routeName,
          arguments: arguments,
          parameters: parameters,
          preventDuplicates: true,
        ) ??
        Future.value(null);
  }

  @override
  Future<T?> navigateToAndRemoveAll<T>(
    String routeName, {
    dynamic arguments,
    Map<String, String>? parameters,
  }) {
    return Get.offAllNamed<T>(
          routeName,
          arguments: arguments,
          parameters: parameters,
        ) ??
        Future.value(null);
  }

  @override
  Future<T?> navigateToAndRemoveUntil<T>(
    String routeName, {
    dynamic arguments,
    Map<String, String>? parameters,
  }) {
    return Get.offAndToNamed<T>(
          routeName,
          arguments: arguments,
          parameters: parameters,
        ) ??
        Future.value(null);
  }

  @override
  void goBack<T>({T? result}) {
    Get.back<T>(result: result);
  }

  @override
  void showSnackbar({
    required String title,
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    Get.snackbar(
      title,
      message,
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
    return Get.dialog<T>(
      AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          if (cancelText != null)
            TextButton(
              onPressed: () => Get.back(result: false),
              child: Text(cancelText),
            ),
          if (confirmText != null)
            TextButton(
              onPressed: () => Get.back(result: true),
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
    return Get.bottomSheet<T>(
      child,
      isScrollControlled: isScrollControlled,
      enableDrag: enableDrag,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    );
  }
}

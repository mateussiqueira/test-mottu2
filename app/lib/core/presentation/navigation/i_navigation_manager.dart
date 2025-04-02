import 'package:flutter/material.dart';

abstract class INavigationManager {
  Future<T?> navigateTo<T>(
    String routeName, {
    dynamic arguments,
    Map<String, String>? parameters,
  });

  Future<T?> navigateToAndRemoveAll<T>(
    String routeName, {
    dynamic arguments,
    Map<String, String>? parameters,
  });

  Future<T?> navigateToAndRemoveUntil<T>(
    String routeName, {
    dynamic arguments,
    Map<String, String>? parameters,
  });

  void goBack<T>({T? result});

  void showSnackbar({
    required String title,
    required String message,
    Duration duration = const Duration(seconds: 3),
  });

  Future<T?> showDialog<T>({
    required String title,
    required String message,
    String? confirmText,
    String? cancelText,
    bool barrierDismissible = true,
  });

  Future<T?> showBottomSheet<T>({
    required Widget child,
    bool isScrollControlled = true,
    bool enableDrag = true,
  });
}

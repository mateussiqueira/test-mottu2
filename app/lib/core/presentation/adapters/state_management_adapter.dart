import 'package:flutter/material.dart';

enum SnackPosition {
  TOP,
  CENTER,
  BOTTOM,
}

abstract class StateManagementAdapter {
  /// Navega para uma rota nomeada e substitui a rota atual
  Future<T?> toNamed<T>(
    String routeName, {
    dynamic arguments,
    Map<String, String>? parameters,
  });

  /// Navega para uma rota nomeada e remove todas as rotas anteriores
  Future<T?> offAllNamed<T>(
    String routeName, {
    dynamic arguments,
    Map<String, String>? parameters,
  });

  /// Navega para uma rota nomeada e substitui a rota atual
  Future<T?> pushReplacementNamed<T>(
    String routeName, {
    dynamic arguments,
    Map<String, String>? parameters,
  });

  /// Retorna para a rota anterior
  void back<T>({T? result});

  /// Registra uma dependência
  void put<T>(
    T dependency, {
    String? tag,
    bool permanent = false,
  });

  /// Registra uma dependência lazy
  void lazyPut<T>(
    T Function() factory, {
    String? tag,
    bool fenix = true,
  });

  /// Obtém uma dependência registrada
  T find<T>({String? tag});

  /// Verifica se uma dependência está registrada
  bool isRegistered<T>({String? tag});

  /// Remove uma dependência registrada
  Future<bool> delete<T>({String? tag});

  /// Remove todas as dependências registradas
  Future<void> deleteAll();

  /// Mostra um snackbar
  void showSnackbar({
    required String title,
    required String message,
    SnackPosition position = SnackPosition.BOTTOM,
    Duration duration = const Duration(seconds: 3),
  });

  /// Mostra um diálogo
  Future<T?> showDialog<T>({
    required String title,
    required String message,
    String? confirmText,
    String? cancelText,
    bool barrierDismissible = true,
  });

  /// Mostra um bottom sheet
  Future<T?> showBottomSheet<T>({
    required Widget child,
    bool isScrollControlled = true,
    bool enableDrag = true,
  });
}

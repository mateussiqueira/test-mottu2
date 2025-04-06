import 'package:flutter/material.dart';

class AppLifecycleObserver extends WidgetsBindingObserver {
  final VoidCallback? onDetach;
  final VoidCallback? onHidden;

  AppLifecycleObserver({
    this.onDetach,
    this.onHidden,
  });

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.detached:
        onDetach?.call();
        break;
      case AppLifecycleState.hidden:
        onHidden?.call();
        break;
      default:
        break;
    }
  }
}

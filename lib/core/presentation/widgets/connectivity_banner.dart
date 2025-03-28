import 'dart:async';

import 'package:flutter/material.dart';

import '../../di/service_locator.dart';
import '../../services/connectivity_service.dart';

class ConnectivityBanner extends StatefulWidget {
  const ConnectivityBanner({super.key});

  @override
  State<ConnectivityBanner> createState() => _ConnectivityBannerState();
}

class _ConnectivityBannerState extends State<ConnectivityBanner> {
  late Timer _timer;
  bool _isConnected = true;

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
    _timer =
        Timer.periodic(const Duration(seconds: 5), (_) => _checkConnectivity());
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Future<void> _checkConnectivity() async {
    final isConnected = await getIt<ConnectivityService>().checkConnectivity();
    if (mounted && isConnected != _isConnected) {
      setState(() {
        _isConnected = isConnected;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isConnected) {
      return Container(
        width: double.infinity,
        color: Colors.red,
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: const Text(
          'No internet connection',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }
}

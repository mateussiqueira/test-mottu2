import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_constants.dart';
import '../../services/connectivity_service.dart';

class ConnectivityStatus extends StatelessWidget {
  final ConnectivityService _connectivityService =
      Get.find<ConnectivityService>();

  ConnectivityStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: _connectivityService.onConnectivityChanged,
      initialData: true,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print('Error in connectivity status: ${snapshot.error}');
        }

        final isConnected = snapshot.data ?? true;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: isConnected ? 0 : 40,
          color: Colors.red,
          child: const Center(
            child: Text(
              AppConstants.errorNoInternet,
              style: TextStyle(
                color: Colors.white,
                fontSize: AppConstants.bodyMediumSize,
              ),
            ),
          ),
        );
      },
    );
  }
}

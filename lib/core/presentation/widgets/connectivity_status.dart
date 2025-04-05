
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../services/connectivity_service.dart';

class ConnectivityStatusWidget extends StatelessWidget {
  const ConnectivityStatusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final connectivityService = Get.find<ConnectivityService>();
    
    return Obx(() {
      return connectivityService.status == ConnectivityStatus.offline
          ? Container(
              width: double.infinity,
              color: Colors.red,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.wifi_off,
                    color: Colors.white,
                    size: 16,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Você está offline. Alguns recursos podem não funcionar.',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            )
          : const SizedBox.shrink();
    });
  }
}

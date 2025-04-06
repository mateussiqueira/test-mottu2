import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/connectivity_service.dart';

class ConnectivityWrapper extends StatelessWidget {
  final Widget child;

  const ConnectivityWrapper({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final connectivityService = Get.put(ConnectivityService());

    return Stack(
      children: [
        child,
        StreamBuilder<bool>(
          stream: connectivityService.onConnectivityChanged,
          builder: (context, snapshot) {
            final isConnected = snapshot.data ?? true;
            if (!isConnected) {
              return const Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Material(
                  color: Colors.red,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Você está offline. Usando dados em cache.',
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center),
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'connectivity_status.dart';

class ConnectivityBanner extends StatelessWidget {
  final Widget child;

  const ConnectivityBanner({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ConnectivityStatusWidget(),
        Expanded(child: child),
      ],
    );
  }
}
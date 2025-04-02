import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ConnectivityService extends GetxService {
  static const platform = MethodChannel('connectivity_status');
  final _isConnected = true.obs;
  bool get isConnected => _isConnected.value;

  @override
  void onInit() {
    super.onInit();
    _initConnectivity();
  }

  Future<void> _initConnectivity() async {
    try {
      platform.setMethodCallHandler(_handleMethod);
      await platform.invokeMethod('getConnectivityStatus');
    } on PlatformException catch (e) {
      print('Failed to get connectivity status: ${e.message}');
    }
  }

  Future<dynamic> _handleMethod(MethodCall call) async {
    switch (call.method) {
      case 'onConnectivityChanged':
        _isConnected.value = call.arguments == 'connected';
        break;
      default:
        throw PlatformException(
          code: 'Unimplemented',
          message: 'Method ${call.method} not implemented',
        );
    }
  }
}

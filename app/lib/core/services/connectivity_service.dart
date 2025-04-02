import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ConnectivityService extends GetxService {
  final EventChannel _channel;

  ConnectivityService({EventChannel? channel})
      : _channel = channel ?? const EventChannel('connectivity');

  @override
  void onInit() {
    super.onInit();
    _initConnectivity();
  }

  Future<void> _initConnectivity() async {
    try {
      final stream = _channel.receiveBroadcastStream();
      await stream.first;
    } on PlatformException catch (e) {
      print('Failed to get connectivity status: ${e.message}');
    }
  }

  Future<bool> checkConnectivity() async {
    try {
      final stream = _channel.receiveBroadcastStream();
      return await stream.first as bool;
    } catch (e) {
      return true; // Return true on error to allow app to continue
    }
  }

  Stream<bool> get onConnectivityChanged {
    try {
      return _channel.receiveBroadcastStream().map((event) => event as bool);
    } catch (e) {
      return Stream.value(
          true); // Return true on error to allow app to continue
    }
  }
}

import 'package:flutter/services.dart';

class ConnectivityService {
  final EventChannel _channel;
  static const _channelName = 'connectivity_service';

  ConnectivityService({EventChannel? channel})
      : _channel = channel ?? const EventChannel(_channelName);

  Future<bool> checkConnectivity() async {
    try {
      final result = await _channel.receiveBroadcastStream().first;
      return result as bool;
    } on PlatformException catch (_) {
      return true; // Return true on error to avoid blocking the app
    }
  }

  Stream<bool> get onConnectivityChanged {
    try {
      return _channel.receiveBroadcastStream().map((event) => event as bool);
    } on PlatformException catch (_) {
      return Stream.value(true); // Return true stream on error
    }
  }
}

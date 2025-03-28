import 'package:flutter/services.dart';

class ConnectivityService {
  final EventChannel _connectivityChannel =
      const EventChannel('com.mateussiqueira.pokeapi/connectivity');

  Future<bool> checkConnectivity() async {
    try {
      return await _connectivityChannel.receiveBroadcastStream().first as bool;
    } catch (e) {
      print('Error checking connectivity: $e');
      return true;
    }
  }

  Stream<bool> get onConnectivityChanged {
    try {
      return _connectivityChannel
          .receiveBroadcastStream()
          .map((dynamic isConnected) => isConnected as bool)
          .handleError((error) {
        print('Error in connectivity stream: $error');
        return true;
      }, test: (error) => true);
    } catch (e) {
      print('Error setting up connectivity stream: $e');
      return Stream.value(true);
    }
  }
}

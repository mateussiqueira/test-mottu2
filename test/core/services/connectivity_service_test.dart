import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pokeapi/core/services/connectivity_service.dart';

@GenerateMocks([MethodChannel])
void main() {
  late ConnectivityService connectivityService;
  late MockMethodChannel mockChannel;

  setUp(() {
    mockChannel = MockMethodChannel();
    connectivityService = ConnectivityService(mockChannel);
  });

  group('ConnectivityService', () {
    test('should check connectivity', () async {
      when(mockChannel.invokeMethod('checkConnectivity'))
          .thenAnswer((_) async => true);

      final isConnected = await connectivityService.checkConnectivity();

      expect(isConnected, true);
      verify(mockChannel.invokeMethod('checkConnectivity')).called(1);
    });

    test('should handle connectivity check error', () async {
      when(mockChannel.invokeMethod('checkConnectivity'))
          .thenThrow(PlatformException(
        code: 'CONNECTIVITY_ERROR',
        message: 'Failed to check connectivity',
      ));

      final isConnected = await connectivityService.checkConnectivity();

      expect(isConnected, true); // Should return true on error
      verify(mockChannel.invokeMethod('checkConnectivity')).called(1);
    });

    test('should get connectivity stream', () {
      when(mockChannel.receiveBroadcastStream())
          .thenAnswer((_) => Stream.value(true));

      final stream = connectivityService.onConnectivityChanged;

      expect(stream, isNotNull);
      verify(mockChannel.receiveBroadcastStream()).called(1);
    });

    test('should handle stream error', () {
      when(mockChannel.receiveBroadcastStream()).thenThrow(PlatformException(
        code: 'STREAM_ERROR',
        message: 'Failed to get connectivity stream',
      ));

      final stream = connectivityService.onConnectivityChanged;

      expect(stream, isNotNull);
      verify(mockChannel.receiveBroadcastStream()).called(1);
    });
  });
}

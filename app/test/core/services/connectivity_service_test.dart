import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/core/services/connectivity_service.dart';
import 'package:mockito/mockito.dart';

import '../../../test/mocks.mocks.dart';

void main() {
  late ConnectivityService connectivityService;
  late MockEventChannel mockChannel;

  setUp(() {
    mockChannel = MockEventChannel();
    connectivityService = ConnectivityService(channel: mockChannel);
  });

  group('ConnectivityService', () {
    test('should check connectivity', () async {
      when(mockChannel.receiveBroadcastStream())
          .thenAnswer((_) => Stream.value(true));

      final isConnected = await connectivityService.checkConnectivity();

      expect(isConnected, true);
      verify(mockChannel.receiveBroadcastStream()).called(1);
    });

    test('should handle connectivity check error', () async {
      when(mockChannel.receiveBroadcastStream()).thenThrow(PlatformException(
        code: 'CONNECTIVITY_ERROR',
        message: 'Failed to check connectivity',
      ));

      final isConnected = await connectivityService.checkConnectivity();

      expect(isConnected, true); // Should return true on error
      verify(mockChannel.receiveBroadcastStream()).called(1);
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

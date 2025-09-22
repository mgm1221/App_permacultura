import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'dart:async';

Future<bool> bleConnect(FlutterReactiveBle ble, DiscoveredDevice device) async {
  try {
    final completer = Completer<bool>();
    ble
        .connectToDevice(id: device.id, connectionTimeout: const Duration(seconds: 5))
        .listen(
            (connectionState) {
          print("Connection state: ${connectionState.connectionState}");
          if (connectionState.connectionState == DeviceConnectionState.connected) {
            print("Connected to device");
            if (!completer.isCompleted) completer.complete(true);
          }
        },
        onError: (error) {
          print("Failed to connect: $error");
          if (!completer.isCompleted) completer.complete(false);
        }
    );

    return completer.future;
  } catch (e) {
    print("Connection failed: $e");
    return false;
  }
}

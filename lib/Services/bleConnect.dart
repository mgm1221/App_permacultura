import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'dart:async';

Future<bool> bleConnect(FlutterReactiveBle ble, DiscoveredDevice device) async {
  try {
    final completer = Completer<bool>();
    ble
        .connectToDevice(id: device.id, connectionTimeout: const Duration(seconds: 5))
        .listen(
            (connectionState) {

          if (connectionState.connectionState == DeviceConnectionState.connected) {
            if (!completer.isCompleted) completer.complete(true);
          }
        },
        onError: (error) {

          if (!completer.isCompleted) completer.complete(false);
        }
    );

    return completer.future;
  } catch (e) {

    return false;
  }
}

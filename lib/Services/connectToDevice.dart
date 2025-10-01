import 'dart:async';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'settings_services.dart';
class MiniBle {
  MiniBle(this.ble);
  final FlutterReactiveBle ble;

  final _subs = <String, StreamSubscription<ConnectionStateUpdate>>{};
  final _firstConnected = <String, Completer<void>>{};

  void connectAll() {
    List<String> ids = SettingsService.pairedDeviceId?? [];
    for (final id in ids) {
      _firstConnected[id] = _firstConnected[id] ?? Completer<void>();
      _subs[id]?.cancel();
      _subs[id] = ble
          .connectToDevice(id: id, connectionTimeout: const Duration(seconds: 10))
          .listen((u) {
        if (u.connectionState == DeviceConnectionState.connected &&
            !_firstConnected[id]!.isCompleted) {
          _firstConnected[id]!.complete();
        }
      }, onError: (e) {

        if (!(_firstConnected[id]?.isCompleted ?? true)) {
          _firstConnected[id]!.completeError(e);
        }
      });
    }
  }
  Future<List<Stream<List<int>>>> subscribeWhenReady() async {
    final serviceId = Uuid.parse("6ef43b96-1eb8-4f7c-86a3-90da787c9d94");
    final charId = Uuid.parse("5a9268d9-0ee8-4dea-84c9-47e220e0cb7b");

    List<String> devicesIds = SettingsService.pairedDeviceId ?? [];
    List<Stream<List<int>>> streams = [];
    for(var deviceId in devicesIds) {
      final q = QualifiedCharacteristic(
        deviceId: deviceId,
        serviceId: serviceId,
        characteristicId: charId,
      );
      final stream =  ble.subscribeToCharacteristic(q);
      streams.add(stream);
    }
    return streams;
  }
  Future<void> awaitConnected(String id) async {
    final c = _firstConnected[id] ??= Completer<void>();
    return c.future;
  }

  Future<void> disconnectAll() async {
    for (final s in _subs.values) { await s.cancel(); }
    _subs.clear();
    _firstConnected.clear();
  }
}

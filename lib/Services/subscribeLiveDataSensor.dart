import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:app/Services/settings_services.dart';

List<Stream<List<int>>> subLiveDataSensor(FlutterReactiveBle ble) {
  final serviceId = Uuid.parse("6ef43b96-1eb8-4f7c-86a3-90da787c9d94");
  final charId    = Uuid.parse("5a9268d9-0ee8-4dea-84c9-47e220e0cb7b");

  final List<Stream<List<int>>> streams = [];
  final List<String> devicesIds = (SettingsService.pairedDeviceId ?? []);

  for (var deviceId in devicesIds) {
    final qualChar = QualifiedCharacteristic(
      serviceId: serviceId,
      characteristicId: charId,
      deviceId: deviceId,
    );
    try {
      final stream = ble.subscribeToCharacteristic(qualChar);
      streams.add(stream);
    } catch (e) {
    }
  }

  return streams;
}

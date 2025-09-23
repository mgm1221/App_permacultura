import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'dart:convert';
import 'package:app/Services/settings_services.dart';

Future<bool> sentCredentials(FlutterReactiveBle ble, String deviceId, String ssid, String password) async{
  Uuid serviceId = Uuid.parse("bc6fffe8-c75d-4d8d-9443-1f53d5486860");
  Uuid charId   = Uuid.parse("6c1a7d7b-9b0a-4a94-9a1e-7f8e3d2c1a45");
  final qualChar = QualifiedCharacteristic(serviceId: serviceId, characteristicId: charId, deviceId: deviceId);
  String finalString = ssid + " " + password;
  try{
    await ble.writeCharacteristicWithResponse(qualChar, value: utf8.encode(finalString));
    SettingsService.markParingComplete();
    SettingsService.savePairedDeviceId(deviceId);
    return true;

  }catch(e){
    print("Write failed: $e");
    return false;
  }

}

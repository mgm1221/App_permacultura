import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:app/Services/settings_services.dart';

Future<List<Stream<List<int>>>> subLiveDataSensor(FlutterReactiveBle ble) async{
  Uuid serviceId = Uuid.parse("bc6fffe8-c75d-4d8d-9443-1f53d5486860");
  Uuid charId   = Uuid.parse("6c1a7d7b-9b0a-4a94-9a1e-7f8e3d2c1a45");
  List<Stream<List<int>>> streams = [];
  List<String> devicesIds = (SettingsService.pairedDeviceId ?? []);
  for(var deviceId in devicesIds){
    final qualChar =  QualifiedCharacteristic(serviceId: serviceId,characteristicId: charId,deviceId: deviceId);
    try{
      Stream<List<int>> stream = await ble.subscribeToCharacteristic(qualChar);
      streams.add(stream);
    }catch(e){

    }
  }
  return streams;
}
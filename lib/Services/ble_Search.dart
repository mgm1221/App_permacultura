import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:permission_handler/permission_handler.dart';

Future<List<DiscoveredDevice>> bleScan(FlutterReactiveBle ble) async{
  final names = <DiscoveredDevice>{};
  Uuid serviceId = Uuid.parse("bc6fffe8-c75d-4d8d-9443-1f53d5486860");

  await Permission.bluetooth.request();
  await Future.delayed(const Duration(milliseconds: 500));
  //construimos un stream llamado search

  final search = ble.scanForDevices(withServices: [serviceId]).listen((device) {
    bool repeat = false;
    for(var dev in names){
      if(dev.id == device.id){
        repeat = true;
      }
    }
    if(!repeat){
      names.add(device);
    }
  });

  await Future.delayed(const Duration(seconds: 2));

  // Terminamos la busqueda
  await search.cancel();

  //formateamos resultados en una lista sin repetidos
  final list = names.toList();
  return list;
}
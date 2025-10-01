import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:app/Services/settings_services.dart';
import 'Screens/firstScreen.dart';
import 'Screens/homeScreen.dart';
import 'package:uuid/uuid.dart' as uuid;

final b = FlutterReactiveBle();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SettingsService.init();
  runApp(const MyApp());
  if(SettingsService.isFirstRun){
    var newUuid = uuid.Uuid();
    var id = newUuid.v4();
    SettingsService.saveClientId(id);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final firstRun = SettingsService.isFirstRun;
    return MaterialApp(
      home: firstRun ? FirstScreen(ble: b) : HomeScreen(connectedBefore: false,ble: b),
    );
  }
}


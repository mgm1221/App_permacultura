import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:app/Services/settings_services.dart';
import 'Screens/firstScreen.dart';
import 'Screens/homeScreen.dart';
import 'package:uuid/uuid.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SettingsService.init();
  runApp(const MyApp());
  if(SettingsService.isFirstRun){
    var uuid = Uuid();
    var id = uuid.v4();
    SettingsService.saveClientId(id);
  }

  final mqttClient = MqttClient.withPort('mqtt.permaculturatech.com', SettingsService.clientId ?? '1', 1884);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final firstRun = SettingsService.isFirstRun;
    return MaterialApp(
      home: firstRun ? const FirstScreen() : const HomeScreen(),
    );
  }
}


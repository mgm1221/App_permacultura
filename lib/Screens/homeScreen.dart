import 'package:flutter/material.dart';
import 'package:app/Services/settings_services.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:app/Services/mqttClientCreate.dart';
class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() =>_HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen>{
  final client = createClient();
  void resetSettings(){
    SettingsService.markParingNotComplete();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Home Screen"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed:()=> resetSettings()
                , child: Text("Reset"))
          ],
        ),
      ),
    );
  }
}

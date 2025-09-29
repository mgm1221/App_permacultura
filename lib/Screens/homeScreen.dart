import 'package:flutter/material.dart';
import 'package:app/Services/settings_services.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:app/Services/mqttClientCreate.dart';

class HomeScreen extends StatefulWidget{
  final bool connectedBefore;
  const HomeScreen({super.key, required this.connectedBefore});


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
          mainAxisAlignment: MainAxisAlignment.start,

          children: [
            for (var i in {1,2,3,4})
            Container(
              padding: EdgeInsets.all(8.0),
              child: Row(

                children: [
                  Container(

                    height: 50,
                    width: 50,
                    child: Padding(
                      padding:EdgeInsets.all(16.0),
                      child: const Text("1"),
                    ),
                    color: Colors.blue,

                  ),
                  Expanded(

                    child: Padding(
                      padding:EdgeInsets.all(16.0),
                      child: const Text("Monitor"),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    child: Padding(
                      padding:EdgeInsets.all(16.0),
                      child: const Text("2"),
                    ),
                    color: Colors.blue,
                  ),
                ],
              ),

            ),



        ElevatedButton(onPressed:()=> resetSettings()
                , child: Text("Reset"))
          ],
        ),
      ),
    );
  }
}

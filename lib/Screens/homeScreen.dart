import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:flutter/material.dart';
import 'package:app/Services/settings_services.dart';
import 'package:app/Services/mqttClientCreate.dart';
import 'package:app/Services/subscribeLiveDataSensor.dart';
import 'package:app/Services/connectToDevice.dart';
class HomeScreen extends StatefulWidget{
  final bool connectedBefore;
  final FlutterReactiveBle ble;
  const HomeScreen({super.key, required this.connectedBefore, required this.ble});


  @override
  State<StatefulWidget> createState() =>_HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen>{
  List<Stream<List<int>>>? _streams;
  late final MiniBle minble;


  final client = createClient();

  void resetSettings(){
    SettingsService.markParingNotComplete();
  }
  @override
  void initState() {
    super.initState();
    if(!widget.connectedBefore){
      minble = MiniBle(widget.ble);
      minble.connectAll();

      _setup();
    }

  }
  Future<void> _setup() async {
    try {

      final s = await minble.subscribeWhenReady(); // <- your function
      var streams = subLiveDataSensor(widget.ble);
      setState(() => _streams = s);
    } catch (e) {

    }
  }
  @override
  Widget build(BuildContext context) {
    final streams = subLiveDataSensor(widget.ble);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Home Screen"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,

          children: [
            for (var stream in streams)
            StreamBuilder<List<int>>(
              stream: stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final data = snapshot.data!;
                    // process your byte list -> maybe convert to string, int, etc.
                    return Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(

                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: const Text("1"),
                            ),
                            color: Colors.blue,

                          ),
                          Expanded(

                            child: Padding(
                              padding:const EdgeInsets.all(16.0),
                              child: Text("Monitor ${data[0]}"),
                            ),
                          ),
                          Container(
                            height: 50,
                            width: 50,
                            child: Padding(
                              padding:const EdgeInsets.all(16.0),
                              child: const Text("2"),
                            ),
                            color: Colors.blue,
                          ),
                        ],
                      ),

                    );
                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
            ),

        ElevatedButton(onPressed:()=> resetSettings()
                , child: Text("Reset"))
          ],
        ),
      ),
    );
  }
}

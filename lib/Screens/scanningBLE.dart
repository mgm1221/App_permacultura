import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:app/Services/ble_Search.dart';
import 'package:app/Services/bleConnect.dart';
import 'wifiCredentials.dart';


class ScanScreen extends StatefulWidget{
  final FlutterReactiveBle ble;
  const ScanScreen({super.key, required this.ble});
  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen>{

  List<DiscoveredDevice> devices = [];
  bool loading = false;

  Future<void> _runScan() async {
    setState(() => loading = true);
    try {
      final result = await bleScan(widget.ble);
      setState(() => devices = result);

    } finally {
      if (mounted) setState(() => loading = false);
    }
  }
  Future<void> _runConnect(DiscoveredDevice device) async{
    setState(() =>loading = true);
    bool d = false;
    try{
      d = await bleConnect(widget.ble,device);

    } finally{
      if (d == true){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PantallaCredenciales(ble: widget.ble, deviceId: device.id, deviceName: device.name))
        );
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error de conexión')),
        );
      }

    }
  }

  @override
  void initState(){
    super.initState();
    _runScan();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Dispositivos disponibles'),
          backgroundColor: Colors.greenAccent,
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
            children: [
              for (var d in devices)

                ListTile(
                  title: Text(d.name),
                  trailing: ElevatedButton(onPressed: ()=> _runConnect(d), child: const Text("conectar")),
                ),
            ],
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: _runScan,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
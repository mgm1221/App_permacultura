import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'scanningBLE.dart';

class FirstScreen extends StatefulWidget{
  final FlutterReactiveBle ble;
  const FirstScreen({super.key, required this.ble});

  @override
  State<StatefulWidget> createState() =>_FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen>{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: Text("Iniciar sesion"),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Bienvenido a la aplicacion de Permacultura',
            ),
            ElevatedButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context)=> ScanScreen(ble: widget.ble,),
                    ),
                  );
                },
                child: Text("Conectar con tu dispositivo")
            )
          ],
        ),
      ),
    );
  }
}

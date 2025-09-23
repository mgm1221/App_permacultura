import 'package:flutter/material.dart';
import 'scanningBLE.dart';

class FirstScreen extends StatefulWidget{
  const FirstScreen({super.key});

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
                      builder: (context)=> ScanScreen(),
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

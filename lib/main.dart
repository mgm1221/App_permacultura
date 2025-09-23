import 'package:flutter/material.dart';
import 'package:app/Services/settings_services.dart';
import 'Screens/firstScreen.dart';
import 'Screens/homeScreen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SettingsService.init();
  runApp(const MyApp());

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


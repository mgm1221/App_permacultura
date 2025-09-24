import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'settings_services.dart';

Future<MqttClient>? createClient() async{

  //Crear cliente ademas del handshake con el servidor
  MqttClient mqttClient = MqttServerClient.withPort('mqtt.permaculturatech.com', SettingsService.clientId ?? '1', 1884);
  mqttClient.logging(on: true);
  final connectMessage = MqttConnectMessage()
      .withClientIdentifier(SettingsService.clientId ?? '1')
      .startClean();

  mqttClient.connectionMessage = connectMessage;

  await mqttClient.connect();
  return mqttClient;

}
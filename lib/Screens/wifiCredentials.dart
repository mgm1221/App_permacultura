import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:app/Services/bleSendCredentials.dart';
import 'package:app/Screens/homeScreen.dart';
class PantallaCredenciales extends StatefulWidget {
  final FlutterReactiveBle ble;
  final String deviceId;
  final String deviceName;
  const PantallaCredenciales({super.key, required this.ble, required this.deviceId, required this.deviceName});

  @override
  State<PantallaCredenciales> createState() => _PantallaCredencialesState();
}

class _PantallaCredencialesState extends State<PantallaCredenciales> {
  final _formKey = GlobalKey<FormState>();
  final ssidController = TextEditingController();
  final passController = TextEditingController();
  bool loading = false;

  @override
  void dispose() {
    ssidController.dispose();
    passController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
  }



  Future<void> _execute() async {
    if (!_formKey.currentState!.validate()) return;

    final ssid = ssidController.text.trim();
    final password = passController.text;

    setState(() => loading = true);
    try {
      // If this is async, await it:
      await sentCredentials(widget.ble, widget.deviceId, ssid, password);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Credenciales enviadas ✅')),
      );
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (context) => HomeScreen(),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al enviar: $e')),
      );
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.deviceName;

    return Scaffold(
      appBar: AppBar(
        title: Text('Conectado a $title'),
        backgroundColor: Colors.cyan,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: ssidController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre de la red (SSID)',
                    hintText: 'Ingrese Nombre de la red',
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Ingrese un SSID' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: passController,
                  decoration: const InputDecoration(
                    labelText: 'Contraseña',
                    hintText: 'Ingrese Contraseña de la red',
                  ),
                  obscureText: true,
                  validator: (v) =>
                  (v == null || v.isEmpty) ? 'Ingrese una contraseña' : null,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: loading ? null : _execute,
                    child: loading
                        ? const SizedBox(
                        height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                        : const Text('Enviar credenciales'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ConsultarConductorLicencia extends StatefulWidget {
  static const String routeName = '/ConductorLicencia';
  @override
  _MyScreenState createState() => _MyScreenState();
}

class _MyScreenState extends State<ConsultarConductorLicencia> {
  TextEditingController licenciaController = TextEditingController();
  bool _isLoading = false;
  String mensaje = 'Introduce el numero de licencia.';
  var data = null;

  Future<void> fetchData() async {
    print(licenciaController.text);
    final response = await http.get(Uri.parse(
        'https://transitord20231207185629.azurewebsites.net/api/v1/Licencia/Licencia/cedula/${licenciaController.text}'));
    if (response.statusCode == 200) {
      setState(() {
        data = json.decode(response.body);
        _isLoading = false;
      });
    } else {
      setState(() {
        mensaje = 'Licencia no encontrada.';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Consulta de licencias de conducir",
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.start,
        ),
        backgroundColor: Colors.green,
        elevation: 10,
        shadowColor: Colors.black87,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Titulo con color negro
            const Text(
              'Consulta de conductores',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            // Subtitulo con color más opaco
            const Text(
              'Ingrese la licencia de conducir...',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            TextFormField(
              controller: licenciaController,
              decoration: InputDecoration(
                hintText: 'Ingrese el numero de licencia',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isLoading = true;
                });
                fetchData();
              },
              child: Text('Buscar'),
            ),
            SizedBox(
              height: 1.h,
            ),
            _isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : data != null
                    ? Center(
                        child: Card(
                          margin: EdgeInsets.all(16.0),
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('nombre: ${data['nombre']}'),
                                Text('apellido: ${data['apellido']}'),
                                Text('cedula: ${data['cedula']}'),
                                Text('foto: ${data['foto']}'),
                                Text(
                                    'fecha_Nacimiento: ${data['fecha_Nacimiento']}'),
                                Text('direccion: ${data['direccion']}'),
                                Text('telefono: ${data['telefono']}'),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Text(mensaje),
          ],
        ),
      ),
    );
  }
}

class DetalleMultaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalle de la Multa"),
      ),
      body: Center(
        child: Text(
          'Detalles de la Multa',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

// ignore_for_file: avoid_print, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:transitord/pages/WeatherModel.dart';
import 'package:transitord/pages/aplicarMultaPage.dart';
import 'package:transitord/pages/conductorLicenciaPage.dart';
import 'package:transitord/pages/horoscopo.dart';
import 'package:transitord/pages/mapaMultasPage.dart';
import 'package:transitord/pages/multasRegistradasPages.dart';
import 'package:transitord/pages/noticiasDigesettPage.dart';
import 'package:transitord/pages/tarifarioMultasPages.dart';
import 'package:transitord/pages/vehiculoPlacaPage.dart';

void main() {
  runApp(const MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  static const String tarifarioRoute = '/tarifario';
  static const String consultasvehiculosRoute = '/vehiculoPlaca';
  static const String consultasconductoresRoute = '/ConductorLicencia';
  static const String aplicarmultasRoute = '/aplicarmultas';
  static const String multasregistradasRoute = '/multasregistradas';
  static const String mapasmultasRoute = '/mapamultas';
  static const String noticiasRoute = '/noticias';
  static const String climaRoute = '/clima';

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        tarifarioRoute: (context) => TarifarioMultas(),
        consultasvehiculosRoute: (context) => ConsultarVehiculoPlaca(),
        consultasconductoresRoute: (context) => ConsultarConductorLicencia(),
        aplicarmultasRoute: (context) => AplicarMulta(),
        multasregistradasRoute: (context) => MultasRegistradas(),
        mapasmultasRoute: (context) => MapaMultas(),
        noticiasRoute: (context) => NoticiasPage(),
        climaRoute: (context) =>  WeatherScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<String> optionNames = [
    'Tarifario de multas',
    'Consultas de vehiculos',
    'Consultas de conductores',
    'Aplicar multas',
    'Multas registradas',
    'Mapas de multas',
    'Noticias',
    'Estado del clima',
    'Horóscopo',
  ];

  final List<IconData> optionIcons = [
    Icons.assignment,
    Icons.directions_car,
    Icons.person,
    Icons.warning,
    Icons.library_books,
    Icons.map,
    Icons.article,
    Icons.cloud,
    Icons.stars,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menú de Opciones'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'DIGESETT',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.green),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const Text(
              'Selecciona una opción:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20.0),
            GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              shrinkWrap: true,
              children: List.generate(
                9,
                (index) =>
                    OptionCard(index + 1, optionNames[index], optionIcons[index], context),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Policia de transito',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class OptionCardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Opción Seleccionada'),
      ),
      body: const Center(
        child: Text('Contenido de la Opción Seleccionada'),
      ),
    );
  }
}

class OptionCard extends StatelessWidget {
  final int optionNumber;
  final String optionName;
  final IconData optionIcon;
  final BuildContext context;

  const OptionCard(this.optionNumber, this.optionName, this.optionIcon, this.context, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      child: InkWell(
        onTap: () {
          // Aquí puedes manejar la acción cuando se hace clic en la tarjeta.
          // Puedes navegar a otra pantalla o realizar cualquier acción que desees.
          navigateToOption(context);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Puedes reemplazar el Icon con una imagen si lo prefieres.
            Icon(
              optionIcon,
              size: 40.0,
              color: Colors.green,
            ),
            const SizedBox(height: 8.0),
            Text(
              optionName,
              style: const TextStyle(fontSize: 16.0),
              textAlign: TextAlign.center, // Alinea el texto al centro horizontalmente.
            ),
          ],
        ),
      ),
    );
  }

  void navigateToOption(BuildContext context) {
    // Añade lógica para navegar a diferentes rutas según la opción seleccionada
    switch (optionNumber) {
      case 1:
        Navigator.pushNamed(context, MyApp.tarifarioRoute);
        break;
      case 2:
        Navigator.pushNamed(context, MyApp.consultasvehiculosRoute);
        break;
      case 3:
        Navigator.pushNamed(context, MyApp.consultasconductoresRoute);
        break;
      case 4:
        Navigator.pushNamed(context, MyApp.aplicarmultasRoute);
        break;
      case 5:
        Navigator.pushNamed(context, MyApp.multasregistradasRoute);
        break;
      case 6:
        Navigator.pushNamed(context, MyApp.mapasmultasRoute);
        break;
      case 7:
        Navigator.pushNamed(context, MyApp.noticiasRoute);
        break;
      case 8:
        Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WeatherScreen()));
        break;
      case 9:
        Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HoroscopoScreen()));
        break;
      default:
        break;
    }
  }
}

// ignore_for_file: avoid_print, library_private_types_in_public_api, use_super_parameters

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);
  static const String routeName = '/clima';

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final String apiKey = 'b266541f72ee459a349f6291a602ec08';
  final String baseUrl = 'https://api.openweathermap.org/data/2.5/weather';
  String weatherDescription = '';
  double temperature = 0.0;
  double humidity = 0.0;
  double windSpeed = 0.0;

  @override
  void initState() {
    super.initState();
    fetchLocationAndWeather();
  }

  Future<void> fetchLocationAndWeather() async {
    Position position = await _getLocation();
    await fetchWeather(position.latitude, position.longitude);
  }

  Future<Position> _getLocation() async {
    try {
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 5),
        forceAndroidLocationManager: true,
      );
    } catch (e) {
      print('Error al obtener la ubicación: $e');
      return Position(
        latitude: 0.0,
        longitude: 0.0,
        timestamp: DateTime.now(),
        accuracy: 0.0,
        altitude: 0.0,
        heading: 0.0,
        speed: 0.0,
        speedAccuracy: 0.0,
        altitudeAccuracy: 0.0,
        headingAccuracy: 0.0,
      );
    }
  }

  Future<void> fetchWeather(double latitude, double longitude) async {
    final String url = '$baseUrl?lat=$latitude&lon=$longitude&appid=$apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        weatherDescription = data['weather'][0]['description'];
        temperature = data['main']['temp'];
        humidity = data['main']['humidity'].toDouble();
        windSpeed = data['wind']['speed'].toDouble();
      });
    } else {
      print('Error al cargar el clima. Código de respuesta: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 112, 205, 115),
        title: const Text('Estado del Clima'),
      ),
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/Clima.png', width: 150, height: 150,),
            const SizedBox(height: 50,),
            Text(
              'Descripción del Clima: $weatherDescription',
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
            const SizedBox(height: 20),
            Text(
              'Temperatura: $temperature°C',
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
            const SizedBox(height: 20),
            Text(
              'Humedad: $humidity%',
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
            const SizedBox(height: 20),
            Text(
              'Velocidad del Viento: $windSpeed m/s',
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

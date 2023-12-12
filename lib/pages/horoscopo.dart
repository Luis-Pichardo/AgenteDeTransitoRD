// ignore_for_file: library_private_types_in_public_api, avoid_print, use_super_parameters, unused_local_variable

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyAppStateful(),
    );
  }
}

class MyAppStateful extends StatefulWidget {
  const MyAppStateful({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyAppStateful> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: createHoroscopoScreen(),
    );
  }
}

HoroscopoScreen createHoroscopoScreen() {
  return const HoroscopoScreen();
}

class HoroscopoScreen extends StatefulWidget {
  const HoroscopoScreen({Key? key}) : super(key: key);

  @override
  _HoroscopoScreenState createState() => _HoroscopoScreenState();
}

class _HoroscopoScreenState extends State<HoroscopoScreen> {
  Map<String, dynamic>? horoscopo;

  // Define horóscopos para cada signo
  final Map<String, String> horoscoposPorSigno = {
  "Acuario": "Hoy es un día para la introspección y la reflexión. Aprovecha para conectar contigo mismo y encontrar respuestas a preguntas importantes en tu vida.",
  "Piscis": "La creatividad estará en su punto máximo hoy. Es un buen momento para explorar nuevas ideas, expresarte artísticamente y compartir tu visión única con el mundo.",
  "Aries": "Energía positiva te rodea hoy, Aries. Aprovecha este impulso para abordar desafíos pendientes y avanzar hacia tus metas con confianza y determinación.",
  "Tauro": "La paciencia será tu aliada hoy, Tauro. Enfrenta los desafíos con calma y perseverancia. Recuerda que las mejores cosas a menudo llevan tiempo.",
  "Géminis": "La comunicación será clave hoy, Géminis. Exprésate claramente y escucha atentamente a los demás. Las conexiones significativas pueden surgir de interacciones simples.",
  "Cáncer": "La intuición estará fuerte hoy, Cáncer. Confía en tus corazonadas y presta atención a los mensajes que provienen de tu interior. Puede haber revelaciones importantes.",
  "Leo": "Es un día para brillar, Leo. Tu carisma y confianza te abrirán puertas. Aprovecha las oportunidades para liderar y dejar una impresión duradera.",
  "Virgo": "La organización será clave hoy, Virgo. Ordena tus tareas y prioridades para maximizar la eficiencia. Tu enfoque metódico te llevará al éxito.",
  "Libra": "El equilibrio será esencial hoy, Libra. Encuentra armonía entre tus responsabilidades y el autocuidado. Dedica tiempo tanto al trabajo como al descanso.",
  "Escorpio": "La transformación personal está en camino, Escorpio. Acepta los cambios con valentía y utiliza este periodo para crecer y evolucionar en todos los aspectos de tu vida.",
  "Sagitario": "La aventura te espera hoy, Sagitario. Explora nuevos horizontes, ya sea física o mentalmente. Abraza la curiosidad y descubre algo nuevo.",
  "Capricornio": "El enfoque en metas a largo plazo será beneficioso hoy, Capricornio. Trabaja con disciplina y determinación para avanzar hacia tus objetivos profesionales y personales.",
 };


  @override
  void initState() {
    super.initState();
    cargarHoroscopo();
  }

  String determinarSigno(DateTime fecha) {
    int mes = fecha.month;
    // Lógica para determinar el signo zodiacal según el mes...
    // A modo de ejemplo, asignamos el signo Leo si el mes es 8 (agosto).
    return "Leo";
  }

  Future<void> cargarHoroscopo() async {
    DateTime now = DateTime.now();
    String signo = determinarSigno(now);

    final Map<String, dynamic> datosHoroscopo = {
      "sunsign": signo,
      "horoscope": horoscoposPorSigno[signo] ?? "Texto por defecto si no se encuentra el horóscopo.",
    };

    setState(() {
      horoscopo = datosHoroscopo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Horóscopo'),
        backgroundColor: Colors.green,
      ),
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (horoscopo != null)
              Image.asset('assets/horoscopo.png', width: 150, height: 150,),
            const SizedBox(height: 50),
            Text(
              'Signo: ${horoscopo!["sunsign"]}',
              style: const TextStyle(fontSize: 25),
            ),
            const SizedBox(height: 20),
            if (horoscopo != null)
              Column(
                children: [
                  const Text(
                    'Horóscopo:',
                    style: TextStyle(fontSize: 25),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.all(15),
                    child: Text(
                      horoscopo!["horoscope"],
                      style: const TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'widgets/google_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'widgets/home.dart';
import 'widgets/mostrar_clima_container.dart';
import '../models/weather_location.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // preparar y abrir la comunicacion entre el plugin de Google (e.g., el objeto GoogleSignIn)) y el Android nativo del celular fisico

  await GoogleSignIn.instance.initialize(
    serverClientId:
        "632004573110-0gka00p291ufmaam59ru644srrf43vtv.apps.googleusercontent.com",
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFFAFAFA)),
      debugShowCheckedModeBanner: false,
      home: Home(),
      initialRoute: '/',
      routes: {'/home': (context) => Home()},
      onGenerateRoute: (settings) {
        if (settings.name == '/weather') {
          final location = settings.arguments as WeatherLocation;

          return MaterialPageRoute(
            settings: settings,
            builder: (context) {
              return MostrarClimaContainer(location: location);
            },
          );
        }

        return null;
      },
    );
  }
}

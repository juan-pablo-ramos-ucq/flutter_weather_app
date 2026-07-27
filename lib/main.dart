import 'package:flutter/material.dart';
import 'widgets/home.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // preparar y abrir la comunicacion entre el plugin de Google (e.g., el objeto GoogleSignIn)) y el Android nativo del celular fisico

  await GoogleSignIn.instance.initialize(
    serverClientId: "YOUR_WEB_CLIENT_ID.apps.googleusercontent.com"
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFFAFAFA),
      ),
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 45),
            child: Home(),
          ),
        ),
      ),
    );
  }
}

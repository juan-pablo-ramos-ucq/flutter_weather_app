import 'package:flutter/material.dart';
import 'widgets/google_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'widgets/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // preparar y abrir la comunicacion entre el plugin de Google (e.g., el objeto GoogleSignIn)) y el Android nativo del celular fisico

  await GoogleSignIn.instance.initialize(
    serverClientId: "632004573110-kj2dt3b1nbvsbp142lodei469sjhtk28.apps.googleusercontent.com"
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
      home: GoogleLogin(),
      initialRoute: '/',
      routes: {
        '/login': (context) => GoogleLogin()
      }
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'logo.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/shared_preferences.dart';

class GoogleLogin extends StatelessWidget {
  GoogleLogin({super.key});

  final PreferencesService _prefsService = PreferencesService();

  Future<void> _signIn(BuildContext context) async {
    try {
      final user = await GoogleSignIn.instance.authenticate();
      
      await _prefsService.saveUser(
        user.displayName ?? '',
        user.photoUrl ?? '',
        user.email,
      );

      if (context.mounted) Navigator.pushReplacementNamed(context, '/home');
    } on GoogleSignInException catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.description ?? 'No se pudo iniciar sesión'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Logo(),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Login',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.nunito(
                          fontSize: 21,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => _signIn(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFEAF4FF),
                          foregroundColor: const Color(0xFF172033),
                        ),
                        child: const Text('Continue with Google'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'logo.dart';
import 'package:google_fonts/google_fonts.dart';

class GoogleLogin extends StatelessWidget {
  const GoogleLogin({super.key});

  Future<void> _signIn() async {
    await GoogleSignIn.instance.authenticate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 45),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Logo(),
              const SizedBox(height: 8),
              Text(
                'Login',
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(
                  fontSize: 21,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 8),
              OutlinedButton(
                onPressed: _signIn,
                child: const Text('Continuar con Google'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

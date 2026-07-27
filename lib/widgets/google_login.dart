import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';  

class GoogleLogin extends StatelessWidget {
  const GoogleLogin({super.key});

  Future<void> _signIn() async {
    await GoogleSignIn.instance.authenticate();
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: _signIn,
      child: const Text('Continuar con Google'),
    );
  }
}
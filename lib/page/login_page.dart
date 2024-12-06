// '/login' wenn not logged in

import 'package:collector/auth/auth_service.dart';
import 'package:collector/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

final Shader linearGradient = const LinearGradient(
  colors: <Color>[
    Color.fromRGBO(255, 79, 64, 100),
    Color.fromRGBO(255, 68, 221, 100),
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
).createShader(const Rect.fromLTWH(0, 0, 500, 70));

class LoginPageWidget extends StatelessWidget {
  const LoginPageWidget({super.key});

  static const routeName = 'login';
  static const routePath = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: margin),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/images/logo.png', height: 240, width: 240),
              const SizedBox(
                height: 32,
              ),
              Text(
                'Collector App',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 80,
                  height: 0.8,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              ElevatedButton(
                onPressed: () => AuthService().login().then((value) => context.go('/home')),
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(Colors.black),
                ),
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

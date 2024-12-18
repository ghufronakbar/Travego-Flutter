// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:trevago_app/configs/functions/functions.dart';
import 'package:trevago_app/utils/utils.dart';
import 'package:trevago_app/models/users.dart';
import 'package:trevago_app/screens/dashboard_screen.dart';
import 'package:trevago_app/screens/welcome_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  static const String route = "/splash";

  Future<void> checkExistingUser(BuildContext context) async {
    try {
      final Users user = await getExistingUser();
      await Future.delayed(const Duration(seconds: 2), () {
        if (user.token.isEmpty) {
          Navigator.of(context).pushReplacementNamed(WelcomeScreen.route);
        } else {
          Navigator.of(context).pushReplacementNamed(DashboardScreen.route);
        }
      });
    } catch (error) {
      Navigator.of(context).pushReplacementNamed(WelcomeScreen.route);
    }
  }

  @override
  Widget build(BuildContext context) {
    checkExistingUser(context);
    return const Scaffold(
      body: Center(
        child: Image(
          image: AssetImage(ImageUtils.logo),
          width: 176,
        ),
      ),
    );
  }
}

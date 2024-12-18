// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:trevago_app/configs/functions/functions.dart';
import 'package:trevago_app/screens/welcome_screen.dart';

class CustomDialogWidget {
  const CustomDialogWidget();

  static void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const AlertDialog(
        content: SizedBox(
          width: 64,
          height: 64,
          child: Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }

  static void showErrorDialog(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Terjadi Kesalahan!"),
        content: Text(errorMessage),
        actions: [
          TextButton(
            onPressed: () async {
              if (errorMessage.contains("Forbidden")) {
                await logoutAction();
                Navigator.of(context).pushNamedAndRemoveUntil(
                  WelcomeScreen.route,
                  (route) => false,
                );
              } else {
                Navigator.of(context).pop();
              }
            },
            child: const Text("OKE"),
          ),
        ],
      ),
    );
  }
}

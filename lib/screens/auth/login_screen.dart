// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:trevago_app/configs/functions/functions.dart';
import 'package:trevago_app/utils/utils.dart';
import 'package:trevago_app/screens/dashboard_screen.dart';
import 'package:trevago_app/widgets/custom_dialog_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String route = "/login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameTextContrroller =
      TextEditingController();
  final TextEditingController _passwordTextContrroller =
      TextEditingController();
  bool securePass = true;
  bool remember = false;

  Future<void> handleLogin() async {
    try {
      if (validation()) {
        showDialog(
          // ?Loading Dialog
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
        await loginAction(
          _usernameTextContrroller.text,
          _passwordTextContrroller.text,
        );
        Navigator.of(context).pushNamedAndRemoveUntil(
          DashboardScreen.route,
          (Route<dynamic> route) => false,
        );
      }
    } catch (error) {
      Navigator.of(context).pop(); // ?Close Loading Dialog
      CustomDialogWidget.showErrorDialog(context, error.toString());
    }
  }

  bool validation() {
    if (_usernameTextContrroller.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Username harus diisi!"),
        backgroundColor: Colors.red,
      ));
      return false;
    } else if (_passwordTextContrroller.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Password harus diisi!"),
        backgroundColor: Colors.red,
      ));
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
        children: [
          const Image(image: AssetImage(ImageUtils.login)),
          const SizedBox(height: 24),
          Center(
            child: Text(
              "Selamat Datang",
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyleUtils.semiboldBlue(32),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "Masuk dengan akun kamu",
            softWrap: true,
            textAlign: TextAlign.center,
            style: TextStyleUtils.mediumBlue(18),
          ),
          const SizedBox(height: 32),
          Form(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // *Username
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: ColourUtils.blue,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.person,
                        color: ColourUtils.lightGray,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextFormField(
                          controller: _usernameTextContrroller,
                          keyboardType: TextInputType.name,
                          style: TextStyleUtils.semiboldBlue(16),
                          decoration: InputDecorationUtils.outlinedBlueBorder(
                              "Username"),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // *Password
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: ColourUtils.blue,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.lock_sharp,
                        color: ColourUtils.lightGray,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextFormField(
                          controller: _passwordTextContrroller,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: securePass,
                          style: TextStyleUtils.semiboldBlue(16),
                          decoration: InputDecorationUtils.outlinedBlueBorder(
                              "Kata Sandi"),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            securePass = !securePass;
                          });
                        },
                        style:
                            IconButton.styleFrom(fixedSize: const Size(20, 20)),
                        padding: const EdgeInsets.all(4),
                        icon: Icon(
                          securePass ? Icons.visibility : Icons.visibility_off,
                          color: ColourUtils.lightGray,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Checkbox(
                        value: remember,
                        activeColor: ColourUtils.blue,
                        side: const BorderSide(color: ColourUtils.blue),
                        onChanged: (val) {
                          setState(() {
                            remember = val ?? remember;
                          });
                        },
                      ),
                      Expanded(
                        child: Text(
                          "Ingatkan Saya",
                          style: TextStyleUtils.regularDarkGray(14),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "Lupa Kata Sandi?",
                        style: TextStyleUtils.regularDarkGray(14),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                // *Sign In Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: ElevatedButton(
                    onPressed: () {
                      handleLogin();
                    },
                    style: ButtonStyleUtils.activeButton,
                    child: Text(
                      "MASUK",
                      style: TextStyleUtils.semiboldWhite(16),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                // *Back Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "KEMBALI",
                      style: TextStyleUtils.semiboldGray(16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

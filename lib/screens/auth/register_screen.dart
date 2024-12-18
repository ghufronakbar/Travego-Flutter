// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trevago_app/configs/functions/functions.dart';
import 'package:trevago_app/utils/utils.dart';
import 'package:trevago_app/screens/auth/login_screen.dart';
import 'package:trevago_app/widgets/custom_dialog_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  static const String route = "/register";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _usernameTextController = TextEditingController();
  final TextEditingController _phoneTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _confirmPassTextController =
      TextEditingController();
  bool securePass = true;
  bool secureConfirmPass = true;
  bool agree = false;

  Future<void> handleRegister() async {
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
        await registerAction(
          _nameTextController.text,
          _emailTextController.text,
          _passwordTextController.text,
          _usernameTextController.text,
          _phoneTextController.text,
        );
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Registrasi berhasil!"),
          backgroundColor: ColourUtils.blue,
        ));
        Navigator.of(context).pushNamedAndRemoveUntil(
          LoginScreen.route,
          (Route<dynamic> route) => false,
        );
      }
    } catch (error) {
      Navigator.of(context).pop(); // ?Close Loading Dialog
      CustomDialogWidget.showErrorDialog(context, error.toString());
    }
  }

  bool validation() {
    if (_nameTextController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Nama harus diisi!"),
        backgroundColor: Colors.red,
      ));
      return false;
    } else if (_usernameTextController.text.trim().length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Username harus memiliki minimal 6 karakter!"),
        backgroundColor: Colors.red,
      ));
      return false;
    } else if (_emailTextController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Email harus diisi!"),
        backgroundColor: Colors.red,
      ));
      return false;
    } else if (!_emailTextController.text.contains("@")) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Email tidak sesuai!"),
        backgroundColor: Colors.red,
      ));
      return false;
    } else if (_phoneTextController.text.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Nomor HP tidak sesuai!"),
        backgroundColor: Colors.red,
      ));
      return false;
    } else if (_passwordTextController.text.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Password harus memiliki minimal 8 karakter!"),
        backgroundColor: Colors.red,
      ));
      return false;
    } else if (_confirmPassTextController.text !=
        _passwordTextController.text) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Konfirmasi Password tidak sesuai!"),
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
          const Image(image: AssetImage(ImageUtils.register)),
          const SizedBox(height: 24),
          Center(
            child: Text(
              "Daftar Akun",
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyleUtils.semiboldBlue(32),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "Isi data akun dulu ya...",
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
                // *Name
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
                          controller: _nameTextController,
                          keyboardType: TextInputType.name,
                          style: TextStyleUtils.semiboldBlue(16),
                          decoration: InputDecorationUtils.outlinedBlueBorder(
                              "Nama Pengguna"),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
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
                        Icons.person_pin_sharp,
                        color: ColourUtils.lightGray,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextFormField(
                          controller: _usernameTextController,
                          keyboardType: TextInputType.name,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(50),
                            FilteringTextInputFormatter.deny(RegExp(r"\s+")),
                          ],
                          style: TextStyleUtils.semiboldBlue(16),
                          decoration: InputDecorationUtils.outlinedBlueBorder(
                              "Username"),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // *Email
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
                        Icons.mail,
                        color: ColourUtils.lightGray,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextFormField(
                          controller: _emailTextController,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyleUtils.semiboldBlue(16),
                          decoration:
                              InputDecorationUtils.outlinedBlueBorder("Email"),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // *Phone
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
                        Icons.phone,
                        color: ColourUtils.lightGray,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextFormField(
                          controller: _phoneTextController,
                          keyboardType: TextInputType.phone,
                          style: TextStyleUtils.semiboldBlue(16),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: InputDecorationUtils.outlinedBlueBorder(
                              "08xxxxxxxxxx"),
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
                          controller: _passwordTextController,
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
                          !securePass ? Icons.visibility : Icons.visibility_off,
                          color: ColourUtils.lightGray,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // *Confirm Password
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
                          controller: _confirmPassTextController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: secureConfirmPass,
                          style: TextStyleUtils.semiboldBlue(16),
                          decoration: InputDecorationUtils.outlinedBlueBorder(
                              "Ulangi Kata Sandi"),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            secureConfirmPass = !secureConfirmPass;
                          });
                        },
                        style:
                            IconButton.styleFrom(fixedSize: const Size(20, 20)),
                        padding: const EdgeInsets.all(4),
                        icon: Icon(
                          !secureConfirmPass
                              ? Icons.visibility
                              : Icons.visibility_off,
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
                    children: [
                      Checkbox(
                        value: agree,
                        activeColor: ColourUtils.blue,
                        side: const BorderSide(color: ColourUtils.blue),
                        onChanged: (val) {
                          setState(() {
                            agree = val ?? agree;
                          });
                        },
                      ),
                      Expanded(
                        child: Text(
                          "Saya setuju dengan syarat & kebijakan privasi yang berlaku.",
                          softWrap: true,
                          style: TextStyleUtils.regularDarkGray(14),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                // *Register Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: ElevatedButton(
                    onPressed: () {
                      handleRegister();
                    },
                    style: ButtonStyleUtils.activeButton,
                    child: Text(
                      "BUAT AKUN",
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

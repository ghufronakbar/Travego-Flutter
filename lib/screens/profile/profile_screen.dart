// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trevago_app/configs/functions/functions.dart';
import 'package:trevago_app/utils/utils.dart';
import 'package:trevago_app/models/users.dart';
import 'package:trevago_app/widgets/custom_dialog_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  static const String route = "/profile";

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _phoneTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _usernameTextController = TextEditingController();
  final TextEditingController _oldPassTextController = TextEditingController();
  final TextEditingController _newPassTextController = TextEditingController();
  String token = "", name = "", phone = "", email = "", username = "";

  Future<Users?> retrieveUserProfile(context) async {
    try {
      final Users profile = await getProfile();

      token = profile.token;
      name = profile.name;
      phone = profile.phone;
      email = profile.email;
      username = profile.username;
      _nameTextController.text = profile.name;
      _phoneTextController.text = profile.phone;
      _emailTextController.text = profile.email;
      _usernameTextController.text = profile.username;
      return profile;
    } catch (error) {
      CustomDialogWidget.showErrorDialog(context, error.toString());
      return null;
    }
  }

  Future<void> doEditProfile() async {
    try {
      if (validationProfile()) {
        CustomDialogWidget.showLoadingDialog(context);
        await editProfile(
          _nameTextController.text,
          _phoneTextController.text,
          _emailTextController.text,
          _usernameTextController.text,
          token,
        );
        Navigator.of(context).pop(); // Close Loading Dialog
        Navigator.of(context).pop(); // Close Edit Dialog
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Profil berhasil diperbarui!"),
          backgroundColor: ColourUtils.blue,
        ));
        setState(() {});
      }
    } catch (error) {
      Navigator.of(context).pop(); // Close Loading Dialog
      CustomDialogWidget.showErrorDialog(context, error.toString());
    }
  }

  Future<void> doChangePassword() async {
    try {
      if (validationChangePass()) {
        CustomDialogWidget.showLoadingDialog(context);
        await changePassword(
          username,
          _oldPassTextController.text,
          _newPassTextController.text,
          token,
        );
        Navigator.of(context).pop(); // Close Loading Dialog
        Navigator.of(context).pop(); // Close Edit Dialog
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Password berhasil diperbarui!"),
          backgroundColor: ColourUtils.blue,
        ));
        setState(() {});
      }
    } catch (error) {
      Navigator.of(context).pop(); // Close Loading Dialog
      CustomDialogWidget.showErrorDialog(context, error.toString());
    }
  }

  bool validationProfile() {
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
    }
    return true;
  }

  bool validationChangePass() {
    if (_oldPassTextController.text.length < 8 || _newPassTextController.text.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Harus memiliki minimal 8 karakter!"),
        backgroundColor: Colors.red,
      ));
      return false;
    } else if (_newPassTextController.text == _oldPassTextController.text) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Pastikan password baru berbeda dengan yang lama!"),
        backgroundColor: Colors.red,
      ));
      return false;
    }
    return true;
  }

  void showEditDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Ubah Profil",
          style: TextStyleUtils.boldDarkGray(20),
        ),
        content: ListView(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          shrinkWrap: true,
          children: [
            // *Name
            TextField(
              controller: _nameTextController,
              style: TextStyleUtils.regularDarkGray(16),
              keyboardType: TextInputType.name,
              inputFormatters: [
                LengthLimitingTextInputFormatter(100),
              ],
              cursorColor: ColourUtils.blue,
              decoration: InputDecorationUtils.outlinedDeepGrayBorder("Nama",
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 12,
                ),
              ),
            ),
            const SizedBox(height: 12),
            // *Phone
            TextField(
              controller: _phoneTextController,
              style: TextStyleUtils.regularDarkGray(16),
              keyboardType: TextInputType.phone,
              inputFormatters: [
                LengthLimitingTextInputFormatter(15),
                FilteringTextInputFormatter.digitsOnly,
              ],
              cursorColor: ColourUtils.blue,
              decoration: InputDecorationUtils.outlinedDeepGrayBorder("Nomor Telepon",
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 12,
                ),
              ),
            ),
            const SizedBox(height: 12),
            // *Email
            TextField(
              controller: _emailTextController,
              style: TextStyleUtils.regularDarkGray(16),
              keyboardType: TextInputType.emailAddress,
              inputFormatters: [
                LengthLimitingTextInputFormatter(100),
              ],
              cursorColor: ColourUtils.blue,
              decoration: InputDecorationUtils.outlinedDeepGrayBorder(
                "Email",
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 12,
                ),
              ),
            ),
            const SizedBox(height: 12),
            // *Username
            TextField(
              controller: _usernameTextController,
              style: TextStyleUtils.regularDarkGray(16),
              keyboardType: TextInputType.name,
              inputFormatters: [
                LengthLimitingTextInputFormatter(50),
              ],
              cursorColor: ColourUtils.blue,
              decoration: InputDecorationUtils.outlinedDeepGrayBorder(
                "Username",
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 12,
                ),
              ),
            ),
          ],
        ),
        actions: [
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: ButtonStyleUtils.outlinedActiveButton,
            child: Text(
              "Batal",
              style: TextStyleUtils.semiboldBlue(16),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              doEditProfile();
            },
            style: ButtonStyleUtils.activeButton,
            child: Text(
              "Kirim",
              style: TextStyleUtils.semiboldWhite(16),
            ),
          ),
        ],
      ),
    );
  }

  void showChangePassDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Ganti Password",
          style: TextStyleUtils.boldDarkGray(20),
        ),
        content: ListView(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          shrinkWrap: true,
          children: [
            // *Old Pass
            TextField(
              controller: _oldPassTextController,
              style: TextStyleUtils.regularDarkGray(16),
              keyboardType: TextInputType.visiblePassword,
              inputFormatters: [
                LengthLimitingTextInputFormatter(100),
              ],
              cursorColor: ColourUtils.blue,
              decoration: InputDecorationUtils.outlinedDeepGrayBorder(
                "Masukkan Password Lama",
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 12,
                ),
              ),
            ),
            const SizedBox(height: 12),
            // *New Pass
            TextField(
              controller: _newPassTextController,
              style: TextStyleUtils.regularDarkGray(16),
              keyboardType: TextInputType.visiblePassword,
              inputFormatters: [
                LengthLimitingTextInputFormatter(100),
              ],
              cursorColor: ColourUtils.blue,
              decoration: InputDecorationUtils.outlinedDeepGrayBorder(
                "Masukkan Password Baru",
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 12,
                ),
              ),
            ),
          ],
        ),
        actions: [
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: ButtonStyleUtils.outlinedActiveButton,
            child: Text(
              "Batal",
              style: TextStyleUtils.semiboldBlue(16),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              doChangePassword();
            },
            style: ButtonStyleUtils.activeButton,
            child: Text(
              "Kirim",
              style: TextStyleUtils.semiboldWhite(16),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColourUtils.blue,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.white,
          ),
        ),
        title: Text(
          "Profil",
          style: TextStyleUtils.mediumWhite(20),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 20,
        ),
        children: [
          FutureBuilder(
            future: retrieveUserProfile(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // *Name
                  const Text(
                    "Nama",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12,),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: const Border.fromBorderSide(BorderSide(color: ColourUtils.gray, width: 1,),),
                    ),
                    child: Text(name, style: TextStyleUtils.regularBlue(16),),
                  ),
                  const SizedBox(height: 12),
                  // *Phone
                  const Text(
                    "Nomor Telepon",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: const Border.fromBorderSide(
                        BorderSide(
                          color: ColourUtils.gray,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Text(
                      phone,
                      style: TextStyleUtils.regularBlue(16),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // *Email
                  const Text(
                    "Email",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: const Border.fromBorderSide(
                        BorderSide(
                          color: ColourUtils.gray,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Text(
                      email,
                      style: TextStyleUtils.regularBlue(16),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // *Username
                  const Text(
                    "Username",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: const Border.fromBorderSide(
                        BorderSide(
                          color: ColourUtils.gray,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Text(
                      username,
                      style: TextStyleUtils.regularBlue(16),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            showChangePassDialog();
                          },
                          style: ButtonStyleUtils.outlinedActiveButton,
                          child: Text(
                            "Ganti Password",
                            style: TextStyleUtils.semiboldBlue(16),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            showEditDialog();
                          },
                          style: ButtonStyleUtils.activeButton,
                          child: Text(
                            "Ubah Profil",
                            style: TextStyleUtils.semiboldWhite(16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

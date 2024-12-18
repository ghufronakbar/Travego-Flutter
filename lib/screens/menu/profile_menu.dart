// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:trevago_app/configs/functions/functions.dart';
import 'package:trevago_app/screens/profile/profile_screen.dart';
import 'package:trevago_app/screens/welcome_screen.dart';
import 'package:trevago_app/utils/utils.dart';
import 'package:trevago_app/models/users.dart';
import 'package:trevago_app/widgets/custom_dialog_widget.dart';

class ProfileMenu extends StatefulWidget {
  const ProfileMenu({super.key});

  @override
  State<ProfileMenu> createState() => _ProfileMenuState();
}

class _ProfileMenuState extends State<ProfileMenu> {
  List contentList(BuildContext context) => [
        {
          "icon": const Icon(
            Icons.person_outline,
            color: ColourUtils.darkGray,
          ),
          "title": "Informasi Akun",
          "nav": () => Navigator.of(context).pushNamed(ProfileScreen.route),
        },
        {
          "icon": const Icon(
            Icons.credit_card,
            color: ColourUtils.darkGray,
          ),
          "title": "Transaksi Saya",
          "nav": () => Navigator.of(context).pushNamed(ProfileScreen.route),
        },
        {
          "icon": const Icon(
            Icons.exit_to_app_outlined,
            color: ColourUtils.darkGray,
          ),
          "title": "Keluar",
          "nav": () => handleLogout(context),
        },
      ];

  Future<void> handleLogout(context) async {
    await logoutAction();
    Navigator.of(context).pushNamedAndRemoveUntil(
      WelcomeScreen.route,
      (route) => false,
    );
  }

  Future<Users?> retrieveUserProfile(context) async {
    try {
      final Users profile = await getProfile();
      return profile;
    } catch (error) {
      CustomDialogWidget.showErrorDialog(context, error.toString());
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
        },
        child: ListView(
          padding: const EdgeInsets.only(bottom: 16),
          children: [
            Container(
              height: 200,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: ColourUtils.blue,
                borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(screenWidth / 2)),
              ),
              child: FutureBuilder(
                future: retrieveUserProfile(context),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SizedBox(
                      width: screenWidth / 2,
                      child: Text(
                        snapshot.data!.name,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: TextStyleUtils.mediumWhite(20),
                      ),
                    );
                  }
                  return const Text("");
                },
              ),
            ),
            const SizedBox(height: 16),
            const Divider(
              color: ColourUtils.lightGray,
              thickness: 3,
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              itemCount: contentList(context).length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: contentList(context)[index]["nav"],
                child: Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16,),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        bottom: BorderSide(
                      width: 1,
                      color: ColourUtils.lightGray,
                    ),),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      contentList(context)[index]["icon"],
                      const SizedBox(width: 8),
                      Text(contentList(context)[index]["title"], style: TextStyleUtils.regularDarkGray(20),),
                    ]
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

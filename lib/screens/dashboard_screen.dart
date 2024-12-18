import 'package:flutter/material.dart';
import 'package:trevago_app/utils/utils.dart';
import 'package:trevago_app/screens/menu/dashboard_menu.dart';
import 'package:trevago_app/screens/menu/ordered_menu.dart';
import 'package:trevago_app/screens/menu/profile_menu.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  static const String route = "/dashboard";

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int currentIndex = 0;

  Widget loadContent() {
    if (currentIndex == 0) {
      return const DashboardMenu();
    } else if (currentIndex == 1) {
      return const Center(
        child: OrderedMenu(),
      );
    }
    return const Center(
      child: ProfileMenu(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loadContent(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        backgroundColor: Colors.white,
        selectedItemColor: ColourUtils.blue,
        unselectedItemColor: ColourUtils.gray,
        showUnselectedLabels: true,
        elevation: 16,
        selectedLabelStyle: TextStyleUtils.mediumBlue(16),
        unselectedLabelStyle: TextStyleUtils.regularGray(14),
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, color: ColourUtils.lightGray,),
            activeIcon: Icon(Icons.home, color: ColourUtils.blue,),
            label: "Beranda",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_outlined, color: ColourUtils.lightGray,),
            activeIcon: Icon(Icons.list, color: ColourUtils.blue,),
            label: "Pesanan",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined, color: ColourUtils.lightGray,),
            activeIcon: Icon(Icons.person, color: ColourUtils.blue,),
            label: "Saya",
          ),
        ],
      ),
    );
  }
}

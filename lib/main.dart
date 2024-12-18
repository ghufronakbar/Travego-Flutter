import 'package:flutter/material.dart';
import 'package:trevago_app/screens/profile/profile_screen.dart';
import 'package:trevago_app/screens/profile/transaction_screen.dart';
import 'package:trevago_app/screens/restaurant/booking_restaurant_screen.dart';
import 'package:trevago_app/screens/restaurant/detail_restaurant_screen.dart';
import 'package:trevago_app/screens/restaurant/restaurants_screen.dart';
import 'package:trevago_app/screens/tours/detail_tour_screen.dart';
import 'package:trevago_app/screens/tours/tours_screen.dart';
import 'package:trevago_app/screens/transports/maps_screen.dart';
import 'package:trevago_app/screens/transports/transports_screen.dart';
import 'package:trevago_app/utils/utils.dart';
import 'package:trevago_app/screens/dashboard_screen.dart';
import 'package:trevago_app/screens/tour_packages/detail_order_package_screen.dart';
import 'package:trevago_app/screens/tour_packages/detail_package_screen.dart';
import 'package:trevago_app/screens/transports/detail_transport_screen.dart';
import 'package:trevago_app/screens/auth/login_screen.dart';
import 'package:trevago_app/screens/tour_packages/order_package_screen.dart';
import 'package:trevago_app/screens/transports/order_transport_screen.dart';
import 'package:trevago_app/screens/tour_packages/packages_screen.dart';
import 'package:trevago_app/screens/auth/register_screen.dart';
import 'package:trevago_app/screens/splash_screen.dart';
import 'package:trevago_app/screens/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Travego',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: ColourUtils.blue,
          secondary: ColourUtils.blue,
          primary: ColourUtils.blue,
        ),
        useMaterial3: true,
      ),
      initialRoute: SplashScreen.route,
      routes: {
        SplashScreen.route: (context) => const SplashScreen(),
        WelcomeScreen.route: (context) => const WelcomeScreen(),
        LoginScreen.route: (context) => const LoginScreen(),
        RegisterScreen.route: (context) => const RegisterScreen(),
        DashboardScreen.route: (context) => const DashboardScreen(),
        DetailPackageScreen.route: (context) => const DetailPackageScreen(),
        OrderPackageScreen.route: (context) => const OrderPackageScreen(),
        OrderTransportScreen.route: (context) => const OrderTransportScreen(),
        DetailTransportScreen.route: (context) => const DetailTransportScreen(),
        DetailTourScreen.route: (context) => const DetailTourScreen(),
        DetailOrderPackageScreen.route: (context) => DetailOrderPackageScreen(),
        PackagesScreen.route: (context) => const PackagesScreen(),
        ToursScreen.route: (context) => const ToursScreen(),
        TransportsScreen.route: (context) => const TransportsScreen(),
        RestaurantsScreen.route: (context) => const RestaurantsScreen(),
        DetailRestaurantScreen.route: (context) => const DetailRestaurantScreen(),
        BookingRestaurantScreen.route: (context) => const BookingRestaurantScreen(),
        TransactionScreen.route: (context) => const TransactionScreen(),
        ProfileScreen.route: (context) => const ProfileScreen(),
        MapsScreen.route: (context) => const MapsScreen(),
      },
    );
  }
}
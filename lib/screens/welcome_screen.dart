import 'package:flutter/material.dart';
import 'package:trevago_app/screens/auth/login_screen.dart';
import 'package:trevago_app/screens/auth/register_screen.dart';
import 'package:trevago_app/utils/utils.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  static const String route = "/welcome";

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  Widget _firstPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 72, 24, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Image(
                image: AssetImage(ImageUtils.logo),
                width: 136,
              ),
              const SizedBox(height: 48),
              Text(
                "Nikmati liburanmu",
                style: TextStyleUtils.boldDarkGray(26),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    "dengan ",
                    style: TextStyleUtils.boldDarkGray(26),
                  ),
                  Text(
                    "TraveGo",
                    style: TextStyleUtils.boldBlue(26),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                "Membuat perjalanan Anda sangat nyaman \ndan terpercaya di Jawa Barat.",
                style: TextStyleUtils.regularGray(16),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.ease,
                  );
                },
                style: ButtonStyleUtils.activeButton,
                child: Text(
                  "Eksplor",
                  style: TextStyleUtils.mediumWhite(14),
                ),
              ),
            ],
          ),
        ),
        const Expanded(child: Image(image: AssetImage(ImageUtils.welcome_1))),
      ],
    );
  }

  Widget _secondPage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Expanded(
            child: Center(
              child: Image(image: AssetImage(ImageUtils.welcome_2)),
            ),
          ),
          const SizedBox(height: 40),
          Text(
            "Menjelajahi Tempat Wisata",
            softWrap: true,
            textAlign: TextAlign.center,
            style: TextStyleUtils.boldDarkGray(26),
          ),
          const SizedBox(height: 12),
          Text(
            "Banyak tempat wisata yang ada di daerah \nJawa Barat.",
            softWrap: true,
            textAlign: TextAlign.center,
            style: TextStyleUtils.regularGray(16),
          ),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 10,
                height: 10,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                decoration: const BoxDecoration(
                  color: ColourUtils.blue,
                  shape: BoxShape.circle,
                ),
              ),
              Container(
                width: 10,
                height: 10,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                decoration: const BoxDecoration(
                  color: ColourUtils.lightGray,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          Expanded(
            child: Center(
              child: IconButton(
                onPressed: () {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.ease,
                  );
                },
                padding: const EdgeInsets.all(12),
                style: ButtonStyleUtils.roundedActiveButton,
                icon: const Icon(
                  Icons.arrow_right_alt,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _thirdPage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Expanded(
            child: Center(
              child: Image(image: AssetImage(ImageUtils.welcome_3)),
            ),
          ),
          const SizedBox(height: 40),
          Text(
            "Memilih Tempat Wisata",
            softWrap: true,
            textAlign: TextAlign.center,
            style: TextStyleUtils.boldDarkGray(26),
          ),
          const SizedBox(height: 12),
          Text(
            "Temukan tempat destinasi wisata sesuai \nyang anda inginkan.",
            softWrap: true,
            textAlign: TextAlign.center,
            style: TextStyleUtils.regularGray(16),
          ),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 10,
                height: 10,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                decoration: const BoxDecoration(
                  color: ColourUtils.lightGray,
                  shape: BoxShape.circle,
                ),
              ),
              Container(
                width: 10,
                height: 10,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                decoration: const BoxDecoration(
                  color: ColourUtils.blue,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          Expanded(
            child: Center(
              child: IconButton(
                onPressed: () {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.ease,
                  );
                },
                padding: const EdgeInsets.all(12),
                style: ButtonStyleUtils.roundedActiveButton,
                icon: const Icon(
                  Icons.arrow_right_alt,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _fourthPage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Expanded(
            child: Center(
              child: Image(image: AssetImage(ImageUtils.welcome_4)),
            ),
          ),
          const SizedBox(height: 40),
          Text(
            "TraveGo",
            softWrap: true,
            textAlign: TextAlign.center,
            style: TextStyleUtils.boldBlue(28),
          ),
          const SizedBox(height: 12),
          Text(
            "Temukan tempat destinasi wisata sesuai\nyang anda inginkan dengan TraveGo",
            softWrap: true,
            textAlign: TextAlign.center,
            style: TextStyleUtils.mediumBlue(18),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(LoginScreen.route);
                  },
                  style: ButtonStyleUtils.activeButton.copyWith(
                    padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(
                      EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                  child: Text(
                    "MASUK",
                    style: TextStyleUtils.semiboldWhite(16),
                  ),
                ),
                const SizedBox(height: 24),
                OutlinedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(RegisterScreen.route);
                  },
                  style: ButtonStyleUtils.outlinedActiveButton.copyWith(
                    padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(
                      EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                  child: Text(
                    "DAFTAR",
                    style: TextStyleUtils.semiboldBlue(16),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _firstPage(),
          _secondPage(),
          _thirdPage(),
          _fourthPage(),
        ],
      ),
    );
  }
}

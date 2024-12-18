// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

class ImageUtils {
  static const String logo = "lib/assets/images/logo.png";
  static const String logooo = "lib/assets/images/logooo.png";
  static const String city = "lib/assets/images/city.png";
  static const String login = "lib/assets/images/login.png";
  static const String paymemnt_success =
      "lib/assets/images/paymemnt_success.png";
  static const String register = "lib/assets/images/register.png";
  static const String destination = "lib/assets/images/destination.png";
  static const String restaurant = "lib/assets/images/restaurant.png";
  static const String transport = "lib/assets/images/transport.png";
  static const String traveler = "lib/assets/images/traveler.png";
  static const String welcome_1 = "lib/assets/images/welcome_1.png";
  static const String welcome_2 = "lib/assets/images/welcome_2.png";
  static const String welcome_3 = "lib/assets/images/welcome_3.png";
  static const String welcome_4 = "lib/assets/images/welcome_4.png";
  static const String indomaret = "lib/assets/images/indomaret.png";
  static const String alfamart = "lib/assets/images/alfamart.png";
}

class ColourUtils {
  static const Color lightBlue = Color.fromRGBO(164, 205, 228, 1);
  static const Color blue = Color.fromRGBO(19, 148, 223, 1);
  static const Color yellow = Color.fromRGBO(255, 211, 60, 1);
  static const Color purple = Color.fromRGBO(76, 77, 220, 1);
  static const Color gray = Color.fromRGBO(117, 117, 117, 1);
  static const Color extraLightGray = Color.fromRGBO(232, 232, 232, 1);
  static const Color lightGray = Color.fromRGBO(196, 196, 196, 1);
  static const Color deepGray = Color.fromRGBO(106, 106, 106, 1);
  static const Color violet = Color.fromRGBO(219, 0, 255, 1);
  static const Color redCherry = Color.fromRGBO(217, 66, 66, 1);
  static const Color darkGray = Color.fromRGBO(58, 58, 58, 1);
}

class TextStyleUtils {
  // bold
  static TextStyle boldBlue(double size) => TextStyle(
        fontWeight: FontWeight.bold,
        color: ColourUtils.blue,
        fontSize: size,
      );
  static TextStyle boldDarkGray(double size) => TextStyle(
      fontWeight: FontWeight.bold, color: ColourUtils.darkGray, fontSize: size);
  static TextStyle boldLightGray(double size) => TextStyle(
        fontWeight: FontWeight.bold,
        color: ColourUtils.lightGray,
        fontSize: size,
      );
  static TextStyle boldGray(double size) => TextStyle(
        fontWeight: FontWeight.bold,
        color: ColourUtils.gray,
        fontSize: size,
      );
  static TextStyle boldWhite(double size) => TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: size,
      );
  static TextStyle boldBlack(double size) => TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontSize: size,
      );
  static TextStyle boldRedCherry(double size) => TextStyle(
        fontWeight: FontWeight.bold,
        color: ColourUtils.redCherry,
        fontSize: size,
      );

  // semibold
  static TextStyle semiboldBlue(double size) => TextStyle(
        fontWeight: FontWeight.w600,
        color: ColourUtils.blue,
        fontSize: size,
      );
  static TextStyle semiboldDarkGray(double size) => TextStyle(
        fontWeight: FontWeight.w600,
        color: ColourUtils.darkGray,
        fontSize: size,
      );
  static TextStyle semiboldLightGray(double size) => TextStyle(
        fontWeight: FontWeight.w600,
        color: ColourUtils.lightGray,
        fontSize: size,
      );
  static TextStyle semiboldGray(double size) => TextStyle(
        fontWeight: FontWeight.w600,
        color: ColourUtils.gray,
        fontSize: size,
      );
  static TextStyle semiboldWhite(double size) => TextStyle(
        fontWeight: FontWeight.w600,
        color: Colors.white,
        fontSize: size,
      );
  static TextStyle semiboldBlack(double size) => TextStyle(
        fontWeight: FontWeight.w600,
        color: Colors.black,
        fontSize: size,
      );
  static TextStyle semiboldRedCherry(double size) => TextStyle(
        fontWeight: FontWeight.w600,
        color: ColourUtils.redCherry,
        fontSize: size,
      );

  // medium
  static TextStyle mediumDarkGray(double size) => TextStyle(
        fontWeight: FontWeight.w500,
        color: ColourUtils.darkGray,
        fontSize: size,
      );
  static TextStyle mediumLightGray(double size) => TextStyle(
        fontWeight: FontWeight.w500,
        color: ColourUtils.lightGray,
        fontSize: size,
      );
  static TextStyle mediumGray(double size) => TextStyle(
        fontWeight: FontWeight.w500,
        color: ColourUtils.gray,
        fontSize: size,
      );
  static TextStyle mediumBlue(double size) => TextStyle(
        fontWeight: FontWeight.w500,
        color: ColourUtils.blue,
        fontSize: size,
      );
  static TextStyle mediumWhite(double size) => TextStyle(
        fontWeight: FontWeight.w500,
        color: Colors.white,
        fontSize: size,
      );
  static TextStyle mediumBlack(double size) => TextStyle(
        fontWeight: FontWeight.w500,
        color: Colors.black,
        fontSize: size,
      );
  static TextStyle mediumRedCherry(double size) => TextStyle(
        fontWeight: FontWeight.w500,
        color: ColourUtils.redCherry,
        fontSize: size,
      );

  // regular
  static TextStyle regularDarkGray(double size) => TextStyle(
        fontWeight: FontWeight.w400,
        color: ColourUtils.darkGray,
        fontSize: size,
      );
  static TextStyle regularLightGray(double size) => TextStyle(
        fontWeight: FontWeight.w400,
        color: ColourUtils.lightGray,
        fontSize: size,
      );
  static TextStyle regularGray(double size) => TextStyle(
        fontWeight: FontWeight.w400,
        color: ColourUtils.gray,
        fontSize: size,
      );
  static TextStyle regularBlue(double size) => TextStyle(
        fontWeight: FontWeight.w400,
        color: ColourUtils.blue,
        fontSize: size,
      );
  static TextStyle regularWhite(double size) => TextStyle(
        fontWeight: FontWeight.w400,
        color: Colors.white,
        fontSize: size,
      );
  static TextStyle regularBlack(double size) => TextStyle(
        fontWeight: FontWeight.w400,
        color: Colors.black,
        fontSize: size,
      );
  static TextStyle regularRedCherry(double size) => TextStyle(
        fontWeight: FontWeight.w400,
        color: ColourUtils.redCherry,
        fontSize: size,
      );
}

class ButtonStyleUtils {
  static ButtonStyle activeButton = ButtonStyle(
    backgroundColor: WidgetStateProperty.all<Color>(ColourUtils.blue),
    elevation: WidgetStateProperty.all<double>(0),
    shape: WidgetStateProperty.all<OutlinedBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(
          color: ColourUtils.blue,
          width: 1,
        ),
      ),
    ),
  );

  static ButtonStyle roundedActiveButton = ButtonStyle(
    backgroundColor: WidgetStateProperty.all<Color>(ColourUtils.blue),
    elevation: WidgetStateProperty.all<double>(0),
    shape: WidgetStateProperty.all<OutlinedBorder>(
      const CircleBorder(
        side: BorderSide(
          color: ColourUtils.blue,
          width: 1,
        ),
      ),
    ),
  );

  static ButtonStyle outlinedActiveButton = ButtonStyle(
    elevation: WidgetStateProperty.all<double>(0),
    side: WidgetStateProperty.all<BorderSide>(
      const BorderSide(
        color: ColourUtils.blue,
        style: BorderStyle.solid,
        width: 2,
      ),
    ),
    shape: WidgetStateProperty.all<OutlinedBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );
}

class InputDecorationUtils {
  static InputDecoration outlinedBlueBorder(
    String hintText, {
    Widget? suffix,
    Widget? prefix,
    TextStyle? hintStyle,
    EdgeInsetsGeometry? contentPadding,
  }) =>
      InputDecoration(
        suffix: suffix,
        prefix: prefix,
        hintStyle: hintStyle ?? TextStyleUtils.semiboldLightGray(16),
        contentPadding: contentPadding ?? const EdgeInsets.symmetric(horizontal: 8, vertical: 12,),
        isDense: true,
        hintText: hintText,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
      );

  static InputDecoration outlinedGrayBorder(
    String hintText, {
    Widget? suffix,
    Widget? prefix,
    TextStyle? hintStyle,
    EdgeInsetsGeometry? contentPadding,
  }) =>
      InputDecoration(
        suffix: suffix,
        prefix: prefix,
        hintStyle: hintStyle ?? TextStyleUtils.semiboldLightGray(16),
        contentPadding: contentPadding ??
            const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 12,
            ),
        isDense: true,
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: ColourUtils.lightGray),
          borderRadius: BorderRadius.circular(6),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: ColourUtils.lightGray),
          borderRadius: BorderRadius.circular(6),
        ),
      );

  static InputDecoration outlinedDeepGrayBorder(
    String hintText, {
    Widget? suffix,
    Widget? prefix,
    TextStyle? hintStyle,
    EdgeInsetsGeometry? contentPadding,
  }) =>
      InputDecoration(
        suffix: suffix,
        prefix: prefix,
        hintStyle: hintStyle ?? TextStyleUtils.semiboldLightGray(16),
        contentPadding: contentPadding ??
            const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 12,
            ),
        isDense: true,
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: ColourUtils.deepGray),
          borderRadius: BorderRadius.circular(6),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: ColourUtils.deepGray),
          borderRadius: BorderRadius.circular(6),
        ),
      );

  static InputDecoration underlineDefaultBorder(
    String hintText, {
    Widget? suffix,
    Widget? prefix,
    TextStyle? hintStyle,
    EdgeInsetsGeometry? contentPadding,
  }) =>
      InputDecoration(
        isDense: true,
        suffix: suffix,
        prefix: prefix,
        hintStyle: hintStyle ?? TextStyleUtils.semiboldLightGray(16),
        contentPadding: contentPadding ??
            const EdgeInsets.symmetric(
              horizontal: 4,
              vertical: 2,
            ),
        hintText: hintText,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: ColourUtils.gray),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: ColourUtils.blue),
        ),
      );

  static InputDecoration noBorder(
    String hintText, {
    Widget? suffix,
    Widget? prefix,
    TextStyle? hintStyle,
    EdgeInsetsGeometry? contentPadding,
  }) =>
      InputDecoration(
        isDense: true,
        suffix: suffix,
        prefix: prefix,
        hintStyle: hintStyle ?? TextStyleUtils.mediumLightGray(16),
        contentPadding: contentPadding ??
            const EdgeInsets.symmetric(
              horizontal: 4,
              vertical: 2,
            ),
        hintText: hintText,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
      );
}

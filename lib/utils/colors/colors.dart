import 'dart:ui';
import 'package:flutter/cupertino.dart';

class AppColors {
  static const Color C_00B2FF = Color(0xFF00B2FF);
  static const Color C_30A2C5 = Color(0xFF30A2C5);
  static const Color phantom = Color(0xFF674D3F);
  static Color textColor = const Color(0xFFFFFFFF).withOpacity(0.87);
  static const Color passiveTextColor = Color(0xFFAFAFAF);

  //-----------------MAIN-------------------------

  static const Color primary = Color(0xFFFEBB1B);
  static const Color secondary = Color(0xFFFFD300);

  //-----------------ALERT  STATUS-------------------------

  static const Color success = Color(0xFF4AED80);
  static const Color info = Color(0xFF246BFD);
  static const Color warning = Color(0xFFFACC15);
  static const Color error = Color(0xFFF75555);
  static const Color disabled = Color(0xFFD8D8D8);
  static const Color disabledButton = Color(0xFFEBAD18);

  //----------------- GREYSCALE -------------------------

  static const Color c_900 = Color(0xFF212121);
  static const Color c_800 = Color(0xFF424242);
  static const Color c_700 = Color(0xFF616161);
  static const Color c_600 = Color(0xFF757575);
  static const Color c_500 = Color(0xFF9E9E9E);
  static const Color c_400 = Color(0xFFBDBDBD);
  static const Color c_300 = Color(0xFFE0E0E0);
  static const Color c_200 = Color(0xFFEEEEEE);
  static const Color c_100 = Color(0xFFF5F5F5);
  static const Color c_50 = Color(0xFFFAFAFA);

  //----------------- GRADIENTS -------------------------

  static const Gradient gradientOrangeYellow = LinearGradient(
      begin: Alignment.centerRight,
      end: Alignment.centerLeft,
      colors: [
        Color(0xFFFEBB1B),
        Color(0xFFFFC740),
      ]);

  static const Gradient gradientBlue = LinearGradient(
      begin: Alignment.centerRight,
      end: Alignment.centerLeft,
      colors: [
        Color(0xFF335EF7),
        Color(0xFF5F82FF),
      ]);

  static const Gradient gradientPurple = LinearGradient(
      begin: Alignment.centerRight,
      end: Alignment.centerLeft,
      colors: [
        Color(0xFF7210FF),
        Color(0xFF9D59FF),
      ]);

  static const Gradient gradientYellow = LinearGradient(
      begin: Alignment.centerRight,
      end: Alignment.centerLeft,
      colors: [
        Color(0xFFFACC15),
        Color(0xFFFFE580),
      ]);

  static const Gradient gradientGreen = LinearGradient(
      begin: Alignment.centerRight,
      end: Alignment.centerLeft,
      colors: [
        Color(0xFF22BB9C),
        Color(0xFF35DEBC),
      ]);

  static const Gradient gradientRed = LinearGradient(
      begin: Alignment.centerRight,
      end: Alignment.centerLeft,
      colors: [
        Color(0xFFFF4D67),
        Color(0xFFFF8A9B),
      ]);

  //----------------- DARK COLORS -------------------------

  static const Color dark1 = Color(0xFF181A20);
  static const Color dark2 = Color(0xFF1F222A);
  static const Color dark3 = Color(0xFF35383F);

  //----------------- OTHERS COLORS ------------------------

  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color red = Color(0xFFF44336);
  static const Color pink = Color(0xFFE91E63);
  static const Color purple = Color(0xFF9C27B0);
  static const Color deepPurple = Color(0xFF673AB7);
  static const Color indigo = Color(0xFF3F51B5);
  static const Color blue = Color(0xFF2196F3);
  static const Color lightBlue = Color(0xFF03A9F4);
  static const Color cyan = Color(0xFF00BCD4);
  static const Color teal = Color(0xFF009688);
  static const Color green = Color(0xFF4CAF50);
  static const Color lightGreen = Color(0xFF8BC34A);
  static const Color lime = Color(0xFFCDDC39);
  static const Color yellow = Color(0xFFFFEB3B);
  static const Color amber = Color(0xFFFFC107);
  static const Color orange = Color(0xFFFF9800);
  static const Color deepOrange = Color(0xFFFF5722);
  static const Color brown = Color(0xFF795548);
  static const Color blueGrey = Color(0xFF607D8B);

  //----------------- BACKGROUND COLORS ------------------------

  static const Color primaryBackground = Color(0xFFFEBB1B);
  static const Color purpleBackground = Color(0xFFF4ECFF);
  static const Color blueBackground = Color(0xFFF6FAFD);
  static const Color greenBackground = Color(0xFFF2FFFC);
  static const Color orangeBackground = Color(0xFFFFF8ED);
  static const Color pinkBackground = Color(0xFFFFF5F5);
  static const Color yellowBackground = Color(0xFFFFFEE0);

  //----------------- TRANSPARENT COLORS ------------------------

  static const Color primaryTransparent = Color(0xFFFEBB1B);
  static const Color purpleTransparent = Color(0xFF7210FF);
  static const Color blueTransparent = Color(0xFF335EF7);
  static const Color orangeTransparent = Color(0xFFFF9800);
  static const Color yellowTransparent = Color(0xFFFACC15);
  static const Color redTransparent = Color(0xFFF75555);
  static const Color greenTransparent = Color(0xFF4CAF50);
  static const Color cyanTransparent = Color(0xFF00BCD4);
}

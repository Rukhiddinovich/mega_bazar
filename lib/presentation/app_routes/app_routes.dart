import 'package:caffelito/presentation/home/home_screen.dart';
import 'package:caffelito/presentation/splash/splash_screen.dart';
import 'package:flutter/material.dart';

class RouteNames {
  static const String splash = "/";
  static const String homeScreen = "/home_screen";
  static const String detailScreen = "/detail_screen";
}

class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splash:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case RouteNames.homeScreen:
        return MaterialPageRoute(builder: (context) => HomeScreen());
      case RouteNames.detailScreen:
        return MaterialPageRoute(builder: (context) => HomeScreen());
      // case RouteNames.addProduct:
      //   return MaterialPageRoute(
      //       builder: (context) {
      //         final map = (settings.arguments as Map<String, dynamic>);
      //         return AddProductScreen(
      //           barCode: map['product'], code: map['code'],);
      //       });
      default:
        return MaterialPageRoute(
          builder: (context) =>
          const Scaffold(
            body: Center(
              child: Text("Route not available!"),
            ),
          ),
        );
    }
  }
}

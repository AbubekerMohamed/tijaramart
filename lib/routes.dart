import 'package:flutter/material.dart';
import 'package:tijaramart/common/components/bottom_navigation.dart';
import 'package:tijaramart/features/auth/screens/auth_screen.dart';
import 'package:tijaramart/features/home/screens/home_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen(),
      );
    case BottomNavigation.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BottomNavigation(),
      );
    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeScreen(),
      );
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text("Page Not Found"),
          ),
        ),
      );
  }
}

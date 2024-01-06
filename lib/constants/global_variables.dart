import 'package:flutter/material.dart';

const String backendURL = "http://172.20.102.21:3000";

class GlobalVariables {
  // COLORS
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(225, 201, 29, 195),
      Color.fromARGB(255, 95, 97, 209),
    ],
    stops: [0.5, 1.0],
  );

  static const secondaryColor = Color.fromRGBO(0, 115, 255, 1);
  static const backgroundColor = Colors.white;
  static const Color greyBackgroundCOlor = Color(0xffebecee);
  static var selectedNavBarColor = Colors.purple[800]!;
  static const unselectedNavBarColor = Colors.black87;
}

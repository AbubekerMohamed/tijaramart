import 'package:flutter/material.dart';

import 'common/utils/screen_size_config.dart';
import 'constants/global_variables.dart';

ThemeData theme() {
  return ThemeData(
      colorScheme: colorScheme(),
      scaffoldBackgroundColor: GlobalVariables.backgroundColor,
      appBarTheme: appBarTheme(),
      fontFamily: 'Poppins',
      inputDecorationTheme: inputDecorationTheme());
}

InputDecorationTheme inputDecorationTheme() {
  return InputDecorationTheme(
    contentPadding: EdgeInsets.symmetric(
      horizontal: getProportionateScreenWidth(
        20,
      ),
      vertical: getProportionateScreenHeight(
        15,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: kPrimaryColor),
      borderRadius: BorderRadius.circular(20),
      gapPadding: 10,
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.black38),
      borderRadius: BorderRadius.circular(20),
      gapPadding: 10,
    ),
    border: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.black38),
      borderRadius: BorderRadius.circular(20),
      gapPadding: 10,
    ),
  );
}

ColorScheme colorScheme() {
  return const ColorScheme.light(
    primary: Color.fromARGB(255, 136, 0, 255),
  );
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.black),
  );
}

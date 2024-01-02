import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tijaramart/common/components/snackbar.dart';
import 'package:tijaramart/constants/error_handlers.dart';
import 'package:tijaramart/constants/global_variables.dart';
import 'package:tijaramart/features/home/screens/home_screen.dart';
import 'package:tijaramart/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:tijaramart/providers/user_provider.dart';

class AuthService {
  // signup user
  void signUpUser({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      // prepare the object to send to server
      UserModel userModel = UserModel(
          id: "",
          name: name,
          email: email,
          password: password,
          address: "",
          role: "",
          token: "");
      //make the post request
      http.Response res = await http.post(Uri.parse('$backendURL/api/signup'),
          body: userModel.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            "Account Registerd Successfully.",
          );
        },
      );
    } catch (error) {
      // ignore: use_build_context_synchronously
      showSnackBar(
        context,
        error.toString(),
      );
    }
  }

  // sign in user
  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      //make the post request
      http.Response res = await http.post(Uri.parse('$backendURL/api/signin'),
          body: jsonEncode({
            "email": email,
            "password": password,
          }),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          sharedPreferences.setString(
              "x-auth-token", jsonDecode(res.body)['token']);
          Navigator.pushNamedAndRemoveUntil(
              context, HomeScreen.routeName, (route) => false);
        },
      );
    } catch (error) {
      // ignore: use_build_context_synchronously
      showSnackBar(
        context,
        error.toString(),
      );
    }
  }
}

// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tijaramart/common/components/snackbar.dart';
import 'package:tijaramart/constants/error_handlers.dart';
import 'package:tijaramart/constants/global_variables.dart';
import 'package:tijaramart/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:tijaramart/providers/user_provider.dart';

class AuthService {
  // sign up user
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
        token: "",
        cart: [],
      );
      //make the post request
      http.Response res = await http.post(Uri.parse('$backendURL/api/signup'),
          body: userModel.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

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

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          sharedPreferences.setString(
              "x-auth-token", jsonDecode(res.body)['token']);
        },
      );
    } catch (error) {
      showSnackBar(
        context,
        error.toString(),
      );
    }
  }

  void getUserData(BuildContext context) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String? token = sharedPreferences.getString('x-auth-token');
      if (token == null) {
        sharedPreferences.setString('x-auth-token', '');
      }
      http.Response res = await http.post(Uri.parse('$backendURL/tokenIsValid'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token!
          });
      bool response = jsonDecode(res.body);

      if (response == true) {
        // get user data
        http.Response userResponse = await http.get(
          Uri.parse('$backendURL/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token,
          },
        );

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userResponse.body);
      }
    } catch (error) {
      showSnackBar(
        context,
        error.toString(),
      );
    }
  }
}

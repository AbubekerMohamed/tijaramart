import 'package:flutter/material.dart';
import 'package:tijaramart/common/components/snackbar.dart';
import 'package:tijaramart/constants/error_handlers.dart';
import 'package:tijaramart/constants/global_variables.dart';
import 'package:tijaramart/models/user_model.dart';
import 'package:http/http.dart' as http;

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
      http.Response res = await http.post(Uri.parse('$BACKEND_URL/api/signup'),
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
}

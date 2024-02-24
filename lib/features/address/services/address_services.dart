// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:tijaramart/common/components/snackbar.dart';
import 'package:tijaramart/constants/error_handlers.dart';
import 'package:tijaramart/constants/global_variables.dart';
import 'package:tijaramart/models/user_model.dart';
import 'package:tijaramart/providers/user_provider.dart';

class AddressServices {
  void saveUserAddress({
    required BuildContext context,
    required String address,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse("$backendURL/api/save-user-address"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': context.mounted
              ? Provider.of<UserProvider>(
                  context,
                  listen: false,
                ).user.token
              : '',
        },
        body: jsonEncode({'address': address}),
      );
      if (context.mounted) {
        httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            UserModel user = Provider.of<UserProvider>(
              context,
              listen: false,
            ).user.copyWith(address: jsonDecode(response.body)['address']);
            Provider.of<UserProvider>(
              context,
              listen: false,
            ).setUserFromModel(user);
          },
        );
      }
    } catch (error) {
      if (context.mounted) showSnackBar(context, error.toString());
    }
  }

  void placeOrder({
    required BuildContext context,
    required String address,
    required double totalSum,
  }) async {
    final userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );
    try {
      http.Response response = await http.post(
        Uri.parse("$backendURL/api/order"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'address': address,
          'cart': userProvider.user.cart,
          'totalPrice': totalSum,
        }),
      );
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Your order has been placed!');
          UserModel user = userProvider.user.copyWith(cart: []);
          userProvider.setUserFromModel(user);
        },
      );
    } catch (error) {
      if (context.mounted) showSnackBar(context, error.toString());
    }
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:tijaramart/common/components/snackbar.dart';
import 'package:tijaramart/constants/error_handlers.dart';
import 'package:tijaramart/constants/global_variables.dart';
import 'package:tijaramart/models/order_model.dart';
import 'package:tijaramart/providers/user_provider.dart';

class AddressServices {
  Future<List<OrderModel>> fetchMyOrders({
    required BuildContext context,
  }) async {
    List<OrderModel> ordersList = [];
    try {
      http.Response response = await http.get(
        Uri.parse("$backendURL/api/orders/me"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': context.mounted
              ? Provider.of<UserProvider>(
                  context,
                  listen: false,
                ).user.token
              : '',
        },
      );
      if (context.mounted) {
        httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            for (var i = 0; i < jsonDecode(response.body); i++) {
              ordersList.add(
                OrderModel.fromJson(
                  jsonEncode(
                    jsonDecode(response.body[i]),
                  ),
                ),
              );
            }
          },
        );
      }
    } catch (error) {
      if (context.mounted) showSnackBar(context, error.toString());
    }
    return ordersList;
  }
}

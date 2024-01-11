import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:tijaramart/common/components/snackbar.dart';
import 'package:tijaramart/constants/error_handlers.dart';
import 'package:tijaramart/constants/global_variables.dart';
import 'package:tijaramart/models/product_nodel.dart';
import 'package:tijaramart/models/user_model.dart';
import 'package:tijaramart/providers/user_provider.dart';

class CartService {
  void removeFromCart({
    required BuildContext context,
    required ProductModel product,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response response = await http.delete(
        Uri.parse('$backendURL/api/remove-from-cart/${product.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      if (context.mounted) {
        httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            UserModel user = userProvider.user
                .copyWith(cart: jsonDecode(response.body)['cart']);

            userProvider.setUserFromModel(user);
          },
        );
      }
    } catch (error) {
      if (context.mounted) {
        showSnackBar(context, "Product Details Error $error");
      }
    }
  }
}

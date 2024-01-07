import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:tijaramart/common/components/snackbar.dart';
import 'package:tijaramart/constants/error_handlers.dart';
import 'package:tijaramart/constants/global_variables.dart';
import 'package:tijaramart/models/product_nodel.dart';
import 'package:tijaramart/providers/user_provider.dart';

class SearchService {
  // get all products in categories
  Future<List<ProductModel>> getSearchedProducts({
    required BuildContext context,
    required String searchQuery,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<ProductModel> productList = [];
    try {
      http.Response response = await http.get(
        Uri.parse('$backendURL/api/products/search$searchQuery'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );
      if (context.mounted) {
        httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(response.body).length; i++) {
              productList.add(
                ProductModel.fromJson(
                  jsonEncode(
                    jsonDecode(response.body)[i],
                  ),
                ),
              );
            }
          },
        );
      }
    } catch (error) {
      if (context.mounted) {
        showSnackBar(context, "Error from response ${error.toString()}");
      }
    }
    return productList;
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:tijaramart/common/components/snackbar.dart';
import 'package:tijaramart/constants/error_handlers.dart';
import 'package:tijaramart/constants/global_variables.dart';
import 'package:tijaramart/models/order_model.dart';
import 'package:tijaramart/models/product_nodel.dart';
import 'package:tijaramart/providers/user_provider.dart';

class AdminService {
  // bounded to add product backend
  void addProduct(
      {required BuildContext context,
      required String name,
      required String description,
      required double price,
      required double quantity,
      required String category,
      required List<File> images}) async {
    try {
      final cloudinary = CloudinaryPublic(
        "dqgqce5fy",
        "pcldypsv",
      );
      List<String> imageUrls = [];
      for (var i = 0; i < images.length; i++) {
        CloudinaryResponse response = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(
            images[i].path,
            folder: name,
          ),
        );
        imageUrls.add(response.secureUrl);
      }

      ProductModel product = ProductModel(
        name: name,
        description: description,
        quantity: quantity,
        price: price,
        category: category,
        images: imageUrls,
      );

      http.Response response = await http.post(
        Uri.parse("$backendURL/admin/add-product"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': context.mounted
              ? Provider.of<UserProvider>(
                  context,
                  listen: false,
                ).user.token
              : '',
        },
        body: product.toJson(),
      );
      if (context.mounted) {
        httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBar(context, "Product added sucessfully.");
            Navigator.pop(context);
          },
        );
      }
    } catch (error) {
      if (context.mounted) showSnackBar(context, error.toString());
    }
  }

  // bounded to get products
  Future<List<ProductModel>> getAllProducts(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<ProductModel> productList = [];
    try {
      http.Response response = await http.get(
        Uri.parse('$backendURL/admin/get-products'),
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

  // bounded to delete products
  void deleteProduct({
    required BuildContext context,
    required ProductModel product,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response response = await http.post(
        Uri.parse('$backendURL/admin/delete-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id,
        }),
      );
      if (context.mounted) {
        httpErrorHandle(
          response: response,
          context: context,
          onSuccess: onSuccess,
        );
      }
    } catch (error) {
      if (context.mounted) {
        showSnackBar(context, "Error from response ${error.toString()}");
      }
    }
  }

  Future<List<OrderModel>> getAllOrders(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<OrderModel> ordersList = [];

    try {
      http.Response response = await http.get(
        Uri.parse('$backendURL/admin/get-orders'),
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
              ordersList.add(
                OrderModel.fromJson(
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
    return ordersList;
  }

  // changing the steps of orders
  void updateOrderStatus({
    required BuildContext context,
    required int status,
    required OrderModel order,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response response = await http.post(
        Uri.parse('$backendURL/admin/update-order-status'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': order.id,
          'status': status,
        }),
      );
      if (context.mounted) {
        httpErrorHandle(
          response: response,
          context: context,
          onSuccess: onSuccess,
        );
      }
    } catch (error) {
      if (context.mounted) {
        showSnackBar(context, "Error from response ${error.toString()}");
      }
    }
  }
}

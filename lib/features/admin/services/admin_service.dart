import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:tijaramart/common/components/snackbar.dart';
import 'package:tijaramart/constants/error_handlers.dart';
import 'package:tijaramart/constants/global_variables.dart';
import 'package:tijaramart/models/product_nodel.dart';
import 'package:tijaramart/providers/user_provider.dart';

class AdminService {
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
              ? Provider.of<UserProvider>(context).user.token
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
}

import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:tijaramart/common/components/snackbar.dart';

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
    } catch (error) {
      showSnackBar(context, error.toString());
    }
  }
}

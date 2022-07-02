import 'dart:convert';
import 'dart:io';
import 'package:amazon_clone/constants/error_handling.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'package:amazon_clone/constants/utills.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/providers/user_provider.dart';

class AdminServices {
  void sellProduct(
      {required BuildContext context,
      required String name,
      required String description,
      required double price,
      required int quantity,
      required String category,
      required List<File> images}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      // SETTING UP CLOUDINARY
      final cloudinary = CloudinaryPublic("di889ecmh", "kbwvi17q");
      List<String> imageUrls = [];

      // LOOP THROUGH THE IMAGES AND SEND IT TO EMPTY LIST
      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse response = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: name),
        );
        imageUrls.add(response.secureUrl);
      }

      Product product = Product(
        name: name,
        description: description,
        price: price,
        quantity: quantity,
        category: category,
        images: imageUrls,
      );

      http.Response res = await http.post(Uri.parse("$uri/admin/add-product"),
          headers: {
            'Content-Type': 'application/json; Charset=UTF-8',
            'x-auth-token': userProvider.user.token!
          },
          body: jsonEncode(product.toJson()));

      httpErrorHandler(
        response: res,
        context: context,
        onSuccess: () {
          showSnackbar(context, "Product Added Successfully");
          Navigator.pop(context);
        },
      );
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }
}

import 'dart:io';

import 'package:amazon_clone/constants/utills.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/cupertino.dart';

class AdminServices {
  void sellProduct(
      {required BuildContext context,
      required String name,
      required String description,
      required double price,
      required int quantity,
      required String category,
      required List<File> images}) async {
    try {
      // SETTING UP CLOUDINARY
      final cloudinary = CloudinaryPublic("di889ecmh", "kbwvi17q");
      List<String> imageUrls = [];

      // LOOP THROUGH THE IMAGES AND SEND IT TO EMPTY LIST
      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse response = await cloudinary
            .uploadFile(CloudinaryFile.fromFile(images[i].path, folder: name));
        imageUrls.add(response.secureUrl);

        Product product = Product(
          name: name,
          description: description,
          price: price,
          quantity: quantity,
          category: category,
          images: imageUrls,
        );
      }
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }
}

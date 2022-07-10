import 'dart:convert';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'package:amazon_clone/constants/utills.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/providers/user_provider.dart';

class SearchServices {
  Future<List<Product>> fetchSearchProduct(
      {required BuildContext context, required String searchQuery}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response res = await http
          .get(Uri.parse("$uri/api/products/search/$searchQuery"), headers: {
        'Content-Type': 'application/json; Charset=UTF-8',
        'x-auth-token': userProvider.user.token!
      });

      httpErrorHandler(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              productList.add(Product.fromJson(jsonDecode(res.body)[i]));
            }
          });
    } catch (e) {
      showSnackbar(context, e.toString());
    }
    return productList;
  }
}

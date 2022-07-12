import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'package:amazon_clone/constants/utills.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/providers/user_provider.dart';

class ProductDetailServices {
  void rateProduct(
      {required BuildContext context,
      required Product product,
      required double rating}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(Uri.parse("$uri/api/rate-product"),
          headers: {
            'Content-Type': 'application/json; Charset=UTF-8',
            'x-auth-token': userProvider.user.token!
          },
          body: jsonEncode({'id': product.id!, 'rating': rating}));

      httpErrorHandler(response: res, context: context, onSuccess: () {});
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }
}

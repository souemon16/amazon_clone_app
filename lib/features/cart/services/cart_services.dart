import 'dart:convert';
import 'package:amazon_clone/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'package:amazon_clone/constants/utills.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/providers/user_provider.dart';

class CartServices {
  void removeFromCart(
      {required BuildContext context, required Product product}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.delete(
          Uri.parse("$uri/user/remove-from-cart/${product.id}"),
          headers: {
            'Content-Type': 'application/json; Charset=UTF-8',
            'x-auth-token': userProvider.user.token!
          });

      httpErrorHandler(
          response: res,
          context: context,
          onSuccess: () {
            User user =
                userProvider.user.copyWith(cart: jsonDecode(res.body)['cart']);

            userProvider.setUserFromModel(user);
          });
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'package:amazon_clone/constants/utills.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/models/user.dart';

class AddressServices {
  void saveUserAddress(
      {required BuildContext context, required String address}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res =
          await http.post(Uri.parse("$uri/api/save-user-address"),
              headers: {
                'Content-Type': 'application/json; Charset=UTF-8',
                'x-auth-token': userProvider.user.token!
              },
              body: jsonEncode({'address': address}));

      httpErrorHandler(
        response: res,
        context: context,
        onSuccess: () {
          User user = userProvider.user
              .copyWith(address: jsonDecode(res.body)['address']);
          userProvider.setUserFromModel(user);
        },
      );
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  // PLACE ORDER
  void placeOrder(
      {required BuildContext context,
      required String address,
      required double totalSum}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(Uri.parse("$uri/api/oder"), headers: {
        'Content-Type': 'application/json; Charset=UTF-8',
        'x-auth-token': userProvider.user.token!
      }, body: {
        jsonEncode({
          'cart': userProvider.user.cart,
          'address': address,
          'totalSum': totalSum
        })
      });

      httpErrorHandler(
          response: res,
          context: context,
          onSuccess: () {
            showSnackbar(context, "Your order has been placed!");
            User user = userProvider.user.copyWith(cart: []);
            userProvider.setUserFromModel(user);
          });
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }
}

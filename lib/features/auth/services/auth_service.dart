import 'dart:convert';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utills.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class AuthService {
  // SIGNUP USER
  void signUpUser(
      {required BuildContext context,
      required String name,
      required String email,
      required String password}) async {
    try {
      User user = User(
          id: "",
          name: name,
          email: email,
          password: password,
          address: "",
          type: "",
          token: "");

      http.Response res = await http.post(Uri.parse("$uri/api/signup"),
          body: jsonEncode(user),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8"
          });

      httpErrorHandler(
          response: res,
          context: context,
          onSuccess: () {
            showSnackbar(context, "Account Created");
          });
    } catch (e) {
      showSnackbar(context, e.toString());
      print(e);
    }
  }
}

import 'dart:convert';
import 'package:amazon_clone/common/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utills.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:amazon_clone/providers/user_provider.dart';

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
        token: "",
        cart: [],
      );

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
    }
  }

  // SIGNIN USER
  void signinUser(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      http.Response res = await http.post(Uri.parse("$uri/api/signin"),
          body: jsonEncode({"email": email, "password": password}),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8"
          });

      httpErrorHandler(
          response: res,
          context: context,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            userProvider.setUser(res.body);
            await prefs.setString(
                "x-auth-token", jsonDecode(res.body)["token"]);
            Navigator.pushNamedAndRemoveUntil(
                context, BottomBar.routeName, (route) => false);
          });
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  // GET USER DATA
  void getUserData(BuildContext context) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      // SET SHAREDPREFERENCES INSTANCE
      SharedPreferences preferences = await SharedPreferences.getInstance();
      // TRY TO FIND THE TOKEN --
      String? token = preferences.getString("x-auth-token");
      // IF TOKEN NOT FOUND --
      if (token == null) {
        preferences.setString("x-auth-token", '');
      }

      // GET TOKEN VIA HEADER
      http.Response tokenres = await http.post(
        Uri.parse("$uri/istokenvalid"),
        headers: <String, String>{
          'Content-Type': 'application/json; Charset=UTF-8',
          'x-auth-token': token!
        },
      );
      var response = jsonDecode(tokenres.body);

      // IF RESPONSE FOUNDED THEN GET USER DATA
      if (response == true) {
        http.Response userResponse = await http.get(Uri.parse("$uri/"),
            headers: <String, String>{
              'Content-Type': 'application/json; Charset=UTF-8',
              'x-auth-token': token
            });

        userProvider.setUser(userResponse.body);
      }
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }
}

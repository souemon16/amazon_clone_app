import 'dart:convert';

import 'package:amazon_clone/models/user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    id: '',
    name: '',
    email: '',
    password: '',
    address: '',
    token: '',
    type: '',
  );

  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(jsonDecode(user));
    notifyListeners();
  }
}

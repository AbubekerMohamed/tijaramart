import 'package:flutter/material.dart';
import 'package:tijaramart/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel _user = UserModel(
    id: "",
    name: '',
    email: '',
    password: '',
    address: '',
    role: '',
    token: '',
  );

  UserModel get user => _user;

  void setUser(String user) {
    _user = UserModel.fromJson(user);
    notifyListeners();
  }
}
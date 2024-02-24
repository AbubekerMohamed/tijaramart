// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tijaramart/constants/global_variables.dart';
import 'package:tijaramart/models/user_model.dart';
import 'package:tijaramart/providers/user_provider.dart';

class GreetUser extends StatelessWidget {
  VoidCallback onClick;
  GreetUser({
    Key? key,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserModel user = Provider.of<UserProvider>(context).user;
    return Container(
      decoration: const BoxDecoration(
        gradient: GlobalVariables.appBarGradient,
      ),
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
              text: TextSpan(
                  text: "Hello, ",
                  style: const TextStyle(fontSize: 22, color: Colors.black),
                  children: [
                TextSpan(
                  text: user.name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ])),
          IconButton(onPressed: onClick, icon: const Icon(Icons.logout))
        ],
      ),
    );
  }
}

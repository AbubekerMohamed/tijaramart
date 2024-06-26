import 'package:flutter/material.dart';
import 'package:tijaramart/constants/global_variables.dart';
import 'package:tijaramart/features/account/components/greet_user.dart';
import 'package:tijaramart/features/account/components/orders_section.dart';
import 'package:tijaramart/features/account/components/top_chips.dart';
import 'package:tijaramart/features/account/services/account_services.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  'assets/images/amazon_in.png',
                  width: 120,
                  height: 45,
                  color: Colors.black,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Icon(Icons.notifications_outlined),
                    ),
                    Icon(Icons.search_outlined),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          GreetUser(onClick: () {
            AccountServices().logOut(context);
          }),
          const SizedBox(
            height: 10,
          ),
          const TopChips(),
          const SizedBox(
            height: 20,
          ),
          const OrdersSection(),
        ],
      ),
    );
  }
}

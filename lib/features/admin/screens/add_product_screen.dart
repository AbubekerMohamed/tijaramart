import 'package:flutter/material.dart';
import 'package:tijaramart/constants/global_variables.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = "/add-product";
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
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
              title: const Center(
                child: Text(
                  "Add Product",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              )),
        ),
        body: const Center(
          child: Text("Add Products"),
        ));
  }
}

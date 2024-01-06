import 'package:flutter/material.dart';
import 'package:tijaramart/features/admin/screens/add_product_screen.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  void navigateToAddProductScreen() {
    Navigator.pushNamed(context, AddProductScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text("Products"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: navigateToAddProductScreen,
        tooltip: "Add product",
        child: const Icon(
          Icons.add_outlined,
        ),
      ),
    );
  }
}

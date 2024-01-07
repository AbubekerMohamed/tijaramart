import 'package:flutter/material.dart';
import 'package:tijaramart/common/components/loader.dart';
import 'package:tijaramart/features/account/components/product_item.dart';
import 'package:tijaramart/features/admin/screens/add_product_screen.dart';
import 'package:tijaramart/features/admin/services/admin_service.dart';
import 'package:tijaramart/models/product_nodel.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  List<ProductModel>? productList;
  final adminService = AdminService();

  void navigateToAddProductScreen() {
    Navigator.pushNamed(context, AddProductScreen.routeName);
  }

  void getAllProducts() async {
    productList = await adminService.getAllProducts(context);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return productList == null
        ? const Loader()
        : Scaffold(
            body: Center(
              child: Text(productList.toString()),
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

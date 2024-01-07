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

  void deleteProduct(ProductModel product, int index) {
    adminService.deleteProduct(
      context: context,
      product: product,
      onSuccess: () {
        productList!.removeAt(index);
        setState(() {});
      },
    );
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
            body: GridView.builder(
                itemCount: productList!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  var product = productList![index];
                  return Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 140,
                          child: ProductItem(
                            imageUrl: product.images[0],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Text(
                                  product.name,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete_outline),
                              onPressed: () => deleteProduct(product, index),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                }),
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

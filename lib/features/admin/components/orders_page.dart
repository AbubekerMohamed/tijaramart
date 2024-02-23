import 'package:flutter/material.dart';
import 'package:tijaramart/common/components/loader.dart';
import 'package:tijaramart/features/account/components/product_item.dart';
import 'package:tijaramart/features/admin/screens/add_product_screen.dart';
import 'package:tijaramart/features/admin/services/admin_service.dart';
import 'package:tijaramart/models/order_model.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  List<OrderModel>? ordersList;
  final AdminService _adminService = AdminService();

  @override
  void initState() {
    super.initState();
    getOrders();
  }

  void getOrders() async {
    ordersList = await _adminService.getAllOrders(context);
  }

  @override
  Widget build(BuildContext context) {
    return ordersList == null
        ? const Loader()
        : GridView.builder(
            itemCount: ordersList!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (contex, index) {
              final orderData = ordersList![index];
              return SizedBox(
                height: 120,
                child:
                    ProductItem(imageUrl: orderData.products[index].images[0]),
              );
            },
          );
  }
}

import 'package:flutter/material.dart';
import 'package:tijaramart/common/components/loader.dart';
import 'package:tijaramart/constants/global_variables.dart';
import 'package:tijaramart/features/account/components/product_item.dart';
import 'package:tijaramart/features/account/services/account_services.dart';
import 'package:tijaramart/models/order_model.dart';

class OrdersSection extends StatefulWidget {
  const OrdersSection({super.key});

  @override
  State<OrdersSection> createState() => _OrdersSectionState();
}

class _OrdersSectionState extends State<OrdersSection> {
  List<OrderModel>? orders;
  AccountServices _accountServices = AccountServices();

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    orders = await _accountServices.fetchMyOrders(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const Loader()
        : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 15),
                    child: const Text(
                      "Your Orders",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 15),
                    child: Text(
                      "See All",
                      style:
                          TextStyle(color: GlobalVariables.selectedNavBarColor),
                    ),
                  ),
                ],
              ),
              Container(
                height: 170,
                padding: const EdgeInsets.only(left: 10, top: 20, right: 0),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: orders?.length,
                    itemBuilder: ((context, index) {
                      return ProductItem(
                          imageUrl: orders![index].products[0].images[0]);
                    })),
              ),
            ],
          );
  }
}

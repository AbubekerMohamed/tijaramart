// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';

import 'package:tijaramart/models/order_model.dart';

class OrderDetailsScreen extends StatefulWidget {
  static const String routeName = "/order-details-screen";
  OrderModel order;
  OrderDetailsScreen({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

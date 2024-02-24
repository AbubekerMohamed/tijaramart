// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tijaramart/common/components/loader.dart';
import 'package:tijaramart/features/account/components/product_item.dart';
import 'package:tijaramart/features/admin/services/admin_service.dart';
import 'package:tijaramart/features/order_details/screens/order_details_screen.dart';
import 'package:tijaramart/models/admin_model/sale_model.dart';
import 'package:tijaramart/models/order_model.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  int? totalEarnings;
  List<Sale>? earnings;
  final AdminService _adminService = AdminService();

  @override
  void initState() {
    super.initState();
    getEarnings();
  }

  void getEarnings() async {
    var earningsResponse = await _adminService.getEarnings(context);
    totalEarnings = earningsResponse['totalEarnings'];
    earnings = earningsResponse['sales'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return earnings == null || totalEarnings == null
        ? const Loader()
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  "Total Earnings \$$totalEarnings",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          );
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:charts_flutter_updated/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:tijaramart/common/components/loader.dart';
import 'package:tijaramart/features/admin/components/chart_earnings_by_category.dart';
import 'package:tijaramart/features/admin/services/admin_service.dart';
import 'package:tijaramart/models/admin_model/sale_model.dart';

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
                ),
                AspectRatio(
                  aspectRatio: 1.6,
                  child: ChartEarningsByCategory(
                    seriesList: [
                      charts.Series(
                        id: "Sales",
                        data: earnings!,
                        domainFn: (Sale sales, _) => sales.label,
                        measureFn: (Sale sales, _) => sales.earning,
                        seriesColor: charts.ColorUtil.fromDartColor(
                            Colors.deepPurple.shade300),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
  }
}

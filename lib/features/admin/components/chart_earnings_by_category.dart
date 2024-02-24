// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:charts_flutter_updated/flutter.dart' as charts;
import 'package:flutter/material.dart';

import 'package:tijaramart/models/admin_model/sale_model.dart';

class ChartEarningsByCategory extends StatelessWidget {
  final List<charts.Series<Sale, String>> seriesList;
  const ChartEarningsByCategory({
    Key? key,
    required this.seriesList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,
      animate: true,
    );
  }
}

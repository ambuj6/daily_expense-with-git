import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './../controller/transactions_controller.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  final TransactionsController c = Get.find<TransactionsController>();
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: c.groupedTransactionValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  data['day'],
                  data['amount'],
                  c.totalSpending == 0.0
                      ? 0.0
                      : (data['amount'] as double) / c.totalSpending),
            );
          }).toList(),
        ),
      ),
    );
  }
}

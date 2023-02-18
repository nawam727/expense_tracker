import 'package:expense_tracker/bar%20graph/bar_graph.dart';
import 'package:expense_tracker/data/expense_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseSummary extends StatelessWidget {
  final DateTime startOfWeek;

  const ExpenseSummary({
    super.key,
    required this.startOfWeek,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => SizedBox(
        height: 200,
        child: MyBarGraph(
          maxY: 100, 
          monAmount: 30, 
          tueAmount: 40, 
          wedAmount: 34, 
          thuAmount: 4, 
          friAmount: 67, 
          satAmount: 93, 
          sunAmount: 11,
        ),
      ),
    );
  }
}

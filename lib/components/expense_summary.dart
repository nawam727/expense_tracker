import 'package:expense_tracker/bar%20graph/bar_graph.dart';
import 'package:expense_tracker/data/expense_data.dart';
import 'package:expense_tracker/datetime/date_time_helper.dart';
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
    // get yyyymmdd for each day of this week
    String monday = convertDateTimeToString(startOfWeek.add(const Duration(days: 0)));
    String tuesday = convertDateTimeToString(startOfWeek.add(const Duration(days: 1)));
    String wednesday = convertDateTimeToString(startOfWeek.add(const Duration(days: 2)));
    String thursday = convertDateTimeToString(startOfWeek.add(const Duration(days: 3)));
    String friday = convertDateTimeToString(startOfWeek.add(const Duration(days: 4)));
    String saturday = convertDateTimeToString(startOfWeek.add(const Duration(days: 5)));
    String sunday = convertDateTimeToString(startOfWeek.add(const Duration(days: 6)));
    return Consumer<ExpenseData>(
      builder: (context, value, child) => SizedBox(
        height: 200,
        child: MyBarGraph(
          maxY: 100,
          monAmount: value.calculateDailyExpenseSummery()[monday] ?? 0,
          tueAmount: value.calculateDailyExpenseSummery()[tuesday] ?? 0,
          wedAmount: value.calculateDailyExpenseSummery()[wednesday] ?? 0,
          thuAmount: value.calculateDailyExpenseSummery()[thursday] ?? 0,
          friAmount: value.calculateDailyExpenseSummery()[friday] ?? 0,
          satAmount: value.calculateDailyExpenseSummery()[saturday] ?? 0,
          sunAmount: value.calculateDailyExpenseSummery()[sunday] ?? 0,
        ),
      ),
    );
  }
}

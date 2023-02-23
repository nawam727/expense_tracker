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

  //calculate max amount in bar graph
  double calculateMax(
    ExpenseData value,
    String monday,
    String tuesday,
    String wednesday,
    String thursday,
    String friday,
    String saturday,
    String sunday,
  ) {
    double? max = 100;

    List<double> values = [
      value.calculateDailyExpenseSummery()[monday] ?? 0,
      value.calculateDailyExpenseSummery()[tuesday] ?? 0,
      value.calculateDailyExpenseSummery()[wednesday] ?? 0,
      value.calculateDailyExpenseSummery()[thursday] ?? 0,
      value.calculateDailyExpenseSummery()[friday] ?? 0,
      value.calculateDailyExpenseSummery()[saturday] ?? 0,
      value.calculateDailyExpenseSummery()[sunday] ?? 0,
    ];

    //sort from smallest to largest
    values.sort();
    max = values.last * 1.1;

    return max == 0 ? 100 : max;
  }

  //calculate the week summary
  String calculateWeekTotal(
    ExpenseData value,
    String monday,
    String tuesday,
    String wednesday,
    String thursday,
    String friday,
    String saturday,
    String sunday,
  ) {
    List<double> values = [
      value.calculateDailyExpenseSummery()[monday] ?? 0,
      value.calculateDailyExpenseSummery()[tuesday] ?? 0,
      value.calculateDailyExpenseSummery()[wednesday] ?? 0,
      value.calculateDailyExpenseSummery()[thursday] ?? 0,
      value.calculateDailyExpenseSummery()[friday] ?? 0,
      value.calculateDailyExpenseSummery()[saturday] ?? 0,
      value.calculateDailyExpenseSummery()[sunday] ?? 0,
    ];

    double total = 0;
    for (int i = 0; i < values.length; i++) {
      total += values[i];
    }

    return total.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    // get yyyymmdd for each day of this week
    String monday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 0)));
    String tuesday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 1)));
    String wednesday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 2)));
    String thursday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 3)));
    String friday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 4)));
    String saturday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 5)));
    String sunday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 6)));
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Column(
        children: [
          //week total
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              children: [
                const Text(
                  "Week Total: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("Rs " + calculateWeekTotal(value, monday, tuesday, wednesday, thursday, friday, saturday, sunday)),
              ],
            ),
          ),

          //bar graph
          SizedBox(
            height: 200,
            child: MyBarGraph(
              maxY: calculateMax(value, monday, tuesday, wednesday, thursday,
                  friday, saturday, sunday),
              monAmount: value.calculateDailyExpenseSummery()[monday] ?? 0,
              tueAmount: value.calculateDailyExpenseSummery()[tuesday] ?? 0,
              wedAmount: value.calculateDailyExpenseSummery()[wednesday] ?? 0,
              thuAmount: value.calculateDailyExpenseSummery()[thursday] ?? 0,
              friAmount: value.calculateDailyExpenseSummery()[friday] ?? 0,
              satAmount: value.calculateDailyExpenseSummery()[saturday] ?? 0,
              sunAmount: value.calculateDailyExpenseSummery()[sunday] ?? 0,
            ),
          ),
        ],
      ),
    );
  }
}

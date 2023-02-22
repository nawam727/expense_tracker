import 'package:hive_flutter/hive_flutter.dart';
import '../models/expense_item.dart';

class HiveDataBase {
  //reference our box
  final _myBox = Hive.box("expense_database");

  //to write data
  void saveData(List<ExpenseItem> allExpense) {


    List<List<dynamic>> allExpenseFormated = [];

    for (var expense in allExpense) {
      //convert each expenseItem into a List of storable type
      List<dynamic> expenseFormatted = [
        expense.name,
        expense.amount,
        expense.dateTime,
      ];
      allExpenseFormated.add(expenseFormatted);
    }

    _myBox.put("ALL_EXPENSES", allExpenseFormated);

  }

  //read data
  List<ExpenseItem> readData() {
    List savedExpenses = _myBox.get("ALL_EXPENSES") ?? [];
    List<ExpenseItem> allExpenses = [];

    for (int i = 0; i < savedExpenses.length; i++) {
      String name = savedExpenses[i][0];
      String amount = savedExpenses[i][1];
      DateTime dateTime = savedExpenses[i][2];

      ExpenseItem expense = ExpenseItem(
        name: name,
        amount: amount,
        dateTime: dateTime,
      );
      allExpenses.add(expense);
    }

    return allExpenses;
  }
}
